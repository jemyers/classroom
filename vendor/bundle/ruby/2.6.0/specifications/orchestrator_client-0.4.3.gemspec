# -*- encoding: utf-8 -*-
# stub: orchestrator_client 0.4.3 ruby lib

Gem::Specification.new do |s|
  s.name = "orchestrator_client".freeze
  s.version = "0.4.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Puppet".freeze]
  s.date = "2019-09-20"
  s.email = "info@puppetlabs.com".freeze
  s.homepage = "https://github.com/puppetlabs/orchestrator_client-ruby".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Simple Ruby client library for PE Orchestration Services".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<faraday>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<net-http-persistent>.freeze, [">= 0"])
  else
    s.add_dependency(%q<faraday>.freeze, [">= 0"])
    s.add_dependency(%q<net-http-persistent>.freeze, [">= 0"])
  end
end
