# frozen_string_literal: true

require 'spec_helper'
require 'rake'
load File.expand_path('../../../lib/puppet_litmus/inventory_manipulation.rb', __dir__)
include PuppetLitmus::InventoryManipulation # rubocop:disable Style/MixinUsage
describe 'litmus rake tasks' do
  before(:all) do # rubocop:disable RSpec/BeforeAfterAll
    load File.expand_path('../../../lib/puppet_litmus/rake_tasks.rb', __dir__)
    # the spec_prep task is stubbed, rather than load from another gem.
    Rake::Task.define_task(:spec_prep)
  end

  context 'with litmus:metadata task' do
    it 'happy path' do
      metadata = { 'name' => 'puppetlabs-postgresql',
                   'version' => '6.0.0',
                   'operatingsystem_support' =>
  [{ 'operatingsystem' => 'RedHat', 'operatingsystemrelease' => ['5'] },
   { 'operatingsystem' => 'Ubuntu', 'operatingsystemrelease' => ['14.04', '18.04'] }],
                   'template-ref' => 'heads/master-0-g7827fc2' }
      expect(File).to receive(:read).with(any_args).once
      expect(JSON).to receive(:parse).with(any_args).and_return(metadata)
      expect(STDOUT).to receive(:puts).with('redhat-5-x86_64')
      expect(STDOUT).to receive(:puts).with('ubuntu-1404-x86_64')
      expect(STDOUT).to receive(:puts).with('ubuntu-1804-x86_64')
      Rake::Task['litmus:metadata'].invoke
    end
  end

  context 'with litmus:install_modules_from_directory' do
    let(:inventory_hash) { { 'groups' => [{ 'name' => 'ssh_nodes', 'nodes' => [{ 'uri' => 'some.host' }] }] } }
    let(:target_folder) { File.join(Dir.pwd, 'spec/fixtures/modules') }
    let(:dummy_tar) { File.new('spec/data/doot.tar.gz') }

    it 'happy path' do
      stub_const('ENV', ENV.to_hash.merge('TARGET_HOST' => 'some.host'))
      expect_any_instance_of(PuppetLitmus::InventoryManipulation).to receive(:inventory_hash_from_inventory_file).and_return(inventory_hash)
      expect(File).to receive(:directory?).with(target_folder).and_return(true)
      expect_any_instance_of(Object).to receive(:build_modules_in_folder).with(target_folder).and_return([dummy_tar])
      expect(STDOUT).to receive(:puts).with('Building')
      expect(STDOUT).to receive(:puts).with("\nSending")
      expect_any_instance_of(Object).to receive(:upload_file).once
      expect(STDOUT).to receive(:puts).with("\nInstalling")
      expect_any_instance_of(Object).to receive(:run_command).once
      Rake::Task['litmus:install_modules_from_directory'].invoke('./spec/fixtures/modules')
    end
  end

  context 'with litmus:provision_install task' do
    it 'happy path' do
      expect(Rake::Task['spec_prep']).to receive(:invoke).and_return('')
      expect(Rake::Task['litmus:provision_list']).to receive(:invoke).with('default')
      expect(Rake::Task['litmus:install_agent']).to receive(:invoke).with('puppet6')
      expect(Rake::Task['litmus:install_module']).to receive(:invoke)
      Rake::Task['litmus:provision_install'].invoke('default', 'puppet6')
    end
  end

  context 'with litmus:provision task' do
    it 'happy path' do
      results = [{ 'node' => 'localhost',
                   'target' => 'localhost',
                   'action' => 'task',
                   'object' => 'provision::docker',
                   'status' => 'success',
                   'result' => { 'status' => 'ok', 'node_name' => 'localhost:2222' } }]

      allow(File).to receive(:directory?).with(any_args).and_return(true)
      allow_any_instance_of(BoltSpec::Run).to receive(:run_task).with(any_args).and_return(results)
      expect(STDOUT).to receive(:puts).with('localhost:2222, centos:7')
      Rake::Task['litmus:provision'].invoke('docker', 'centos:7')
    end
  end

  context 'with litmus:provision_list task' do
    let(:provision_file) { './provision.yaml' }
    let(:provision_hash) { { 'default' => { 'provisioner' => 'docker', 'images' => ['waffleimage/centos7'] } } }

    it 'no key in provision file' do
      allow(File).to receive(:file?).with(any_args).and_return(true)
      expect(YAML).to receive(:load_file).with(provision_file).and_return(provision_hash)
      expect { Rake::Task['litmus:provision_list'].invoke('deet') }.to raise_error(%r{deet})
    end
  end

  context 'with litmus:check_connectivity task' do
    let(:inventory_hash) { { 'groups' => [{ 'name' => 'ssh_nodes', 'nodes' => [{ 'name' => 'some.host' }] }] } }

    it 'happy path' do
      stub_const('ENV', ENV.to_hash.merge('TARGET_HOST' => 'some.host'))
      expect_any_instance_of(PuppetLitmus::InventoryManipulation).to receive(:inventory_hash_from_inventory_file).and_return(inventory_hash)
      expect_any_instance_of(PuppetLitmus::RakeHelper).to receive(:check_connectivity?).with(inventory_hash, nil).and_return(true)
      Rake::Task['litmus:check_connectivity'].invoke
    end
  end

  context 'with litmus:acceptance:localhost task' do
    it 'calls spec_prep' do
      expect(Rake::Task['spec_prep']).to receive(:invoke).and_return('')
      expect_any_instance_of(RSpec::Core::RakeTask).to receive(:run_task)
      Rake::Task['litmus:acceptance:localhost'].invoke
    end
  end
end
