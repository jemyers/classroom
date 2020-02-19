# -*- encoding: utf-8 -*-
# stub: facterdb 0.8.2 ruby lib

Gem::Specification.new do |s|
  s.name = "facterdb".freeze
  s.version = "0.8.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Micka\u00EBl Can\u00E9vet".freeze]
  s.date = "2019-08-28"
  s.description = "Contains facts from many Facter version on many Operating Systems".freeze
  s.email = ["mickael.canevet@camptocamp.com".freeze]
  s.executables = ["facterdb".freeze]
  s.files = ["bin/facterdb".freeze]
  s.homepage = "http://github.com/camptocamp/facterdb".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "A Database of OS facts provided by Facter".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<github_changelog_generator>.freeze, ["~> 1.10", "< 1.10.4"])
    s.add_runtime_dependency(%q<facter>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<jgrep>.freeze, [">= 0"])
  else
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<github_changelog_generator>.freeze, ["~> 1.10", "< 1.10.4"])
    s.add_dependency(%q<facter>.freeze, [">= 0"])
    s.add_dependency(%q<jgrep>.freeze, [">= 0"])
  end
end
