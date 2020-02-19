# -*- encoding: utf-8 -*-
# stub: libhoney 1.14.4 ruby lib

Gem::Specification.new do |s|
  s.name = "libhoney".freeze
  s.version = "1.14.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["The Honeycomb.io Team".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-02-03"
  s.description = "Ruby gem for sending data to Honeycomb".freeze
  s.email = "support@honeycomb.io".freeze
  s.homepage = "https://github.com/honeycombio/libhoney-rb".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.0".freeze)
  s.rubygems_version = "3.1.2".freeze
  s.summary = "send data to Honeycomb".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bump>.freeze, ["~> 0.5"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 12.3"])
    s.add_development_dependency(%q<rubocop>.freeze, ["< 0.69"])
    s.add_development_dependency(%q<sinatra>.freeze, [">= 0"])
    s.add_development_dependency(%q<sinatra-contrib>.freeze, [">= 0"])
    s.add_development_dependency(%q<spy>.freeze, [">= 0"])
    s.add_development_dependency(%q<webmock>.freeze, ["~> 3.4"])
    s.add_development_dependency(%q<yard>.freeze, [">= 0"])
    s.add_development_dependency(%q<yardstick>.freeze, ["~> 0.9"])
    s.add_runtime_dependency(%q<addressable>.freeze, ["~> 2.0"])
    s.add_runtime_dependency(%q<http>.freeze, [">= 2.0", "< 5.0"])
  else
    s.add_dependency(%q<bump>.freeze, ["~> 0.5"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.3"])
    s.add_dependency(%q<rubocop>.freeze, ["< 0.69"])
    s.add_dependency(%q<sinatra>.freeze, [">= 0"])
    s.add_dependency(%q<sinatra-contrib>.freeze, [">= 0"])
    s.add_dependency(%q<spy>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, ["~> 3.4"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
    s.add_dependency(%q<yardstick>.freeze, ["~> 0.9"])
    s.add_dependency(%q<addressable>.freeze, ["~> 2.0"])
    s.add_dependency(%q<http>.freeze, [">= 2.0", "< 5.0"])
  end
end
