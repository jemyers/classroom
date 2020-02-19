# -*- encoding: utf-8 -*-
# stub: pdk 1.16.0 ruby lib

Gem::Specification.new do |s|
  s.name = "pdk".freeze
  s.version = "1.16.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Puppet, Inc.".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-02-05"
  s.description = "A CLI to facilitate easy, unified development workflows for Puppet modules.".freeze
  s.email = ["pdk-maintainers@puppet.com".freeze]
  s.executables = ["pdk".freeze]
  s.files = ["exe/pdk".freeze]
  s.homepage = "https://github.com/puppetlabs/pdk".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.9".freeze)
  s.rubygems_version = "3.1.2".freeze
  s.summary = "A key part of the Puppet Development Kit, the shortest path to better modules".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<bundler>.freeze, [">= 1.15.0", "< 3.0.0"])
    s.add_runtime_dependency(%q<childprocess>.freeze, ["~> 0.7.1"])
    s.add_runtime_dependency(%q<cri>.freeze, ["~> 2.10"])
    s.add_runtime_dependency(%q<diff-lcs>.freeze, ["= 1.3"])
    s.add_runtime_dependency(%q<ffi>.freeze, ["~> 1.9.0"])
    s.add_runtime_dependency(%q<gettext-setup>.freeze, ["~> 0.24"])
    s.add_runtime_dependency(%q<hitimes>.freeze, ["= 1.3.0"])
    s.add_runtime_dependency(%q<json-schema>.freeze, ["= 2.8.0"])
    s.add_runtime_dependency(%q<json_pure>.freeze, ["~> 2.1.0"])
    s.add_runtime_dependency(%q<minitar>.freeze, ["~> 0.6"])
    s.add_runtime_dependency(%q<pathspec>.freeze, ["~> 0.2.1"])
    s.add_runtime_dependency(%q<tty-prompt>.freeze, ["~> 0.13"])
    s.add_runtime_dependency(%q<tty-spinner>.freeze, ["~> 0.5"])
    s.add_runtime_dependency(%q<tty-which>.freeze, ["~> 0.3"])
    s.add_runtime_dependency(%q<concurrent-ruby>.freeze, ["~> 1.1.5"])
    s.add_runtime_dependency(%q<facter>.freeze, ["~> 2.5.1"])
    s.add_runtime_dependency(%q<httpclient>.freeze, ["~> 2.8.3"])
    s.add_runtime_dependency(%q<deep_merge>.freeze, ["~> 1.1"])
  else
    s.add_dependency(%q<bundler>.freeze, [">= 1.15.0", "< 3.0.0"])
    s.add_dependency(%q<childprocess>.freeze, ["~> 0.7.1"])
    s.add_dependency(%q<cri>.freeze, ["~> 2.10"])
    s.add_dependency(%q<diff-lcs>.freeze, ["= 1.3"])
    s.add_dependency(%q<ffi>.freeze, ["~> 1.9.0"])
    s.add_dependency(%q<gettext-setup>.freeze, ["~> 0.24"])
    s.add_dependency(%q<hitimes>.freeze, ["= 1.3.0"])
    s.add_dependency(%q<json-schema>.freeze, ["= 2.8.0"])
    s.add_dependency(%q<json_pure>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<minitar>.freeze, ["~> 0.6"])
    s.add_dependency(%q<pathspec>.freeze, ["~> 0.2.1"])
    s.add_dependency(%q<tty-prompt>.freeze, ["~> 0.13"])
    s.add_dependency(%q<tty-spinner>.freeze, ["~> 0.5"])
    s.add_dependency(%q<tty-which>.freeze, ["~> 0.3"])
    s.add_dependency(%q<concurrent-ruby>.freeze, ["~> 1.1.5"])
    s.add_dependency(%q<facter>.freeze, ["~> 2.5.1"])
    s.add_dependency(%q<httpclient>.freeze, ["~> 2.8.3"])
    s.add_dependency(%q<deep_merge>.freeze, ["~> 1.1"])
  end
end
