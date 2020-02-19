# -*- encoding: utf-8 -*-
# stub: puppet-strings 2.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "puppet-strings".freeze
  s.version = "2.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Puppet Inc.".freeze]
  s.date = "2019-09-23"
  s.description = "Puppet documentation via YARD".freeze
  s.email = "info@puppet.com".freeze
  s.extra_rdoc_files = ["CHANGELOG.md".freeze, "COMMITTERS.md".freeze, "CONTRIBUTING.md".freeze, "LICENSE".freeze, "README.md".freeze]
  s.files = ["CHANGELOG.md".freeze, "COMMITTERS.md".freeze, "CONTRIBUTING.md".freeze, "LICENSE".freeze, "README.md".freeze]
  s.homepage = "https://github.com/puppetlabs/puppet-strings".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0".freeze)
  s.requirements = ["puppet, >= 4.0.0".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Puppet documentation via YARD".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<yard>.freeze, ["~> 0.9.5"])
    s.add_runtime_dependency(%q<rgen>.freeze, [">= 0"])
  else
    s.add_dependency(%q<yard>.freeze, ["~> 0.9.5"])
    s.add_dependency(%q<rgen>.freeze, [">= 0"])
  end
end
