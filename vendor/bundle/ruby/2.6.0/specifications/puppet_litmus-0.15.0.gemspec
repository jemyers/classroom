# -*- encoding: utf-8 -*-
# stub: puppet_litmus 0.15.0 ruby lib

Gem::Specification.new do |s|
  s.name = "puppet_litmus".freeze
  s.version = "0.15.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Puppet, Inc.".freeze]
  s.date = "2020-02-03"
  s.description = "    Providing a simple command line tool for puppet content creators, to enable simple and complex test deployments.\n".freeze
  s.email = ["info@puppet.com".freeze]
  s.homepage = "https://github.com/puppetlabs/puppet_litmus".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Providing a simple command line tool for puppet content creators, to enable simple and complex test deployments.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<bolt>.freeze, [">= 1.13.1", "< 2.0.0"])
    s.add_runtime_dependency(%q<pdk>.freeze, [">= 1.10.0", "< 2.0.0"])
    s.add_runtime_dependency(%q<tty-spinner>.freeze, [">= 0.5.0", "< 1.0.0"])
    s.add_runtime_dependency(%q<docker-api>.freeze, [">= 1.34", "< 2.0.0"])
    s.add_runtime_dependency(%q<parallel>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<honeycomb-beeline>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bolt>.freeze, [">= 1.13.1", "< 2.0.0"])
    s.add_dependency(%q<pdk>.freeze, [">= 1.10.0", "< 2.0.0"])
    s.add_dependency(%q<tty-spinner>.freeze, [">= 0.5.0", "< 1.0.0"])
    s.add_dependency(%q<docker-api>.freeze, [">= 1.34", "< 2.0.0"])
    s.add_dependency(%q<parallel>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<honeycomb-beeline>.freeze, [">= 0"])
  end
end
