# -*- encoding: utf-8 -*-
# stub: metadata-json-lint 2.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "metadata-json-lint".freeze
  s.version = "2.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Vox Pupuli".freeze]
  s.date = "2018-07-26"
  s.description = "Utility to verify Puppet metadata.json files".freeze
  s.email = "voxpupuli@groups.io".freeze
  s.executables = ["metadata-json-lint".freeze]
  s.files = ["bin/metadata-json-lint".freeze]
  s.homepage = "http://github.com/voxpupuli/metadata-json-lint".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.post_install_message = "\n----------------------------------------------------------\n    For the most accurate results, the semantic_puppet\n    gem should be included within your Gemfile if you\n    use Puppet <= 4.8.x\n----------------------------------------------------------\n".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "3.1.2".freeze
  s.summary = "metadata-json-lint /path/to/metadata.json".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<spdx-licenses>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<json-schema>.freeze, ["~> 2.8"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<semantic_puppet>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.50.0"])
  else
    s.add_dependency(%q<spdx-licenses>.freeze, ["~> 1.0"])
    s.add_dependency(%q<json-schema>.freeze, ["~> 2.8"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<semantic_puppet>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.50.0"])
  end
end
