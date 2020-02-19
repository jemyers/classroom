require 'spec_helper'

require 'puppet/reports'
require 'time'
require 'pathname'
require 'tempfile'
require 'fileutils'

processor = Puppet::Reports.report(:store)

describe processor do
  describe "#process" do
    include PuppetSpec::Files
    before :each do
      Puppet[:reportdir] = File.join(tmpdir('reports'), 'reports')
      @report = YAML.load_file(File.join(PuppetSpec::FIXTURE_DIR, 'yaml/report2.6.x.yaml')).extend processor
    end

    it "should create a report directory for the client if one doesn't exist" do
      @report.process

      expect(File).to be_directory(File.join(Puppet[:reportdir], @report.host))
    end

    it "should write the report to the file in YAML" do
      allow(Time).to receive(:now).and_return(Time.utc(2011,01,06,12,00,00))
      @report.process

      expect(File.read(File.join(Puppet[:reportdir], @report.host, "201101061200.yaml"))).to eq(@report.to_yaml)
    end

    it "rejects invalid hostnames" do
      @report.host = ".."
      expect(Puppet::FileSystem).not_to receive(:exist?)
      expect { @report.process }.to raise_error(ArgumentError, /Invalid node/)
    end
  end

  describe "::destroy" do
    it "rejects invalid hostnames" do
      expect(Puppet::FileSystem).not_to receive(:unlink)
      expect { processor.destroy("..") }.to raise_error(ArgumentError, /Invalid node/)
    end
  end

  describe "::validate_host" do
    ['..', 'hello/', '/hello', 'he/llo', 'hello/..', '.'].each do |node|
      it "rejects #{node.inspect}" do
        expect { processor.validate_host(node) }.to raise_error(ArgumentError, /Invalid node/)
      end
    end

    ['.hello', 'hello.', '..hi', 'hi..'].each do |node|
      it "accepts #{node.inspect}" do
        processor.validate_host(node)
      end
    end
  end
end
