# -*- encoding: utf-8 -*-
# stub: puppet_pot_generator 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "puppet_pot_generator".freeze
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Puppet, Inc.".freeze]
  s.date = "2018-02-06"
  s.description = "    Generates a pot file from your puppet code\n".freeze
  s.email = ["info@puppet.com".freeze]
  s.homepage = "https://github.com/puppetlabs/puppet-pot-generator".freeze
  s.licenses = ["Apache 2.0".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Generates a pot file from your puppet code".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<puppet>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<rspec-collection_matchers>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<rspec-its>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop-rspec>.freeze, [">= 0"])
  else
    s.add_dependency(%q<puppet>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rspec-collection_matchers>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rspec-its>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop-rspec>.freeze, [">= 0"])
  end
end
