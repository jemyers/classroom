# -*- encoding: utf-8 -*-
# stub: mocha 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mocha".freeze
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["James Mead".freeze]
  s.date = "2014-05-13"
  s.description = "Mocking and stubbing library with JMock/SchMock syntax, which allows mocking and stubbing of methods on real (non-mock) classes.".freeze
  s.email = "mocha-developer@googlegroups.com".freeze
  s.homepage = "http://gofreerange.com/mocha/docs".freeze
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Mocking and stubbing library".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<metaclass>.freeze, ["~> 0.0.1"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<introspection>.freeze, ["~> 0.0.1"])
    s.add_development_dependency(%q<yard>.freeze, [">= 0"])
    s.add_development_dependency(%q<redcarpet>.freeze, ["~> 1"])
  else
    s.add_dependency(%q<metaclass>.freeze, ["~> 0.0.1"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<introspection>.freeze, ["~> 0.0.1"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
    s.add_dependency(%q<redcarpet>.freeze, ["~> 1"])
  end
end
