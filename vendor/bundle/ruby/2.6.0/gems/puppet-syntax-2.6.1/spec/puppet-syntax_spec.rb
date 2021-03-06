require 'spec_helper'

describe PuppetSyntax do
  after do
    PuppetSyntax.exclude_paths = []
    PuppetSyntax.app_management = false if Puppet.version.to_i < 5
  end

  it 'should default exclude_paths to include the pkg directory' do
    expect(PuppetSyntax.exclude_paths).to include('pkg/**/*')
  end

  it 'should support setting exclude_paths' do
    PuppetSyntax.exclude_paths = ["foo", "bar/baz"]
    expect(PuppetSyntax.exclude_paths).to eq(["foo", "bar/baz"])
  end

  it 'should support appending exclude_paths' do
    PuppetSyntax.exclude_paths << "foo"
    expect(PuppetSyntax.exclude_paths).to eq(["foo"])
  end

  it 'should support future parser setting' do
    PuppetSyntax.future_parser = true
    expect(PuppetSyntax.future_parser).to eq(true)
  end

  it 'should support app_management setting setting' do
    PuppetSyntax.app_management = true
    expect(PuppetSyntax.app_management).to eq(true)
  end

  it 'should raise error when app_management is disabled on 5.x', :if => (Puppet.version.to_i >= 5) do
    expect { PuppetSyntax.app_management = false }.to raise_error(/app_management cannot be disabled on Puppet 5 or higher/)
  end

  it 'should support a fail_on_deprecation_notices setting' do
    PuppetSyntax.fail_on_deprecation_notices = false
    expect(PuppetSyntax.fail_on_deprecation_notices).to eq(false)
  end

  it 'should support forcing EPP only templates' do
    PuppetSyntax.epp_only = true
    expect(PuppetSyntax.epp_only).to eq(true)
  end

  it 'should support setting paths for manifests, templates and hiera' do
    PuppetSyntax.hieradata_paths = []
    expect(PuppetSyntax.hieradata_paths).to eq([])
    PuppetSyntax.manifests_paths = ["**/environments/production/**/*.pp"]
    expect(PuppetSyntax.manifests_paths).to eq(["**/environments/production/**/*.pp"])
    PuppetSyntax.templates_paths = []
    expect(PuppetSyntax.templates_paths).to eq([])
  end
end
