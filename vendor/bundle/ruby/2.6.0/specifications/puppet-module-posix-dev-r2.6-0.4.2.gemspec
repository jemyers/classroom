# -*- encoding: utf-8 -*-
# stub: puppet-module-posix-dev-r2.6 0.4.2 ruby lib

Gem::Specification.new do |s|
  s.name = "puppet-module-posix-dev-r2.6".freeze
  s.version = "0.4.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Puppet, Inc.".freeze]
  s.date = "2019-08-19"
  s.email = "puppet-module-gems-maintainers@puppet.com".freeze
  s.homepage = "https://github.com/puppetlabs/puppet-module-gems".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "A gem used to manage Puppet module dependencies.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<puppet_litmus>.freeze, [">= 0.4.0", "< 1.0.0"])
    s.add_runtime_dependency(%q<simplecov>.freeze, [">= 0.14.1", "< 1.0.0"])
    s.add_runtime_dependency(%q<puppet-blacksmith>.freeze, [">= 3.4.0"])
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 5.0.0", "< 6.0.0"])
    s.add_runtime_dependency(%q<codecov>.freeze, ["~> 0.1.10"])
    s.add_runtime_dependency(%q<dependency_checker>.freeze, ["~> 0.2"])
    s.add_runtime_dependency(%q<facterdb>.freeze, ["~> 0.8.1"])
    s.add_runtime_dependency(%q<gettext-setup>.freeze, ["~> 0.26"])
    s.add_runtime_dependency(%q<metadata-json-lint>.freeze, [">= 2.0.2", "< 3.0.0"])
    s.add_runtime_dependency(%q<mocha>.freeze, [">= 1.0.0", "< 1.2.0"])
    s.add_runtime_dependency(%q<parallel_tests>.freeze, [">= 2.14.1", "< 2.14.3"])
    s.add_runtime_dependency(%q<parser>.freeze, ["~> 2.5.1.2"])
    s.add_runtime_dependency(%q<pry>.freeze, ["~> 0.10.4"])
    s.add_runtime_dependency(%q<puppet-lint>.freeze, [">= 2.3.0", "< 3.0.0"])
    s.add_runtime_dependency(%q<puppet_pot_generator>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<puppet-strings>.freeze, ["~> 2.0"])
    s.add_runtime_dependency(%q<puppet-resource_api>.freeze, ["~> 1.6"])
    s.add_runtime_dependency(%q<puppet-syntax>.freeze, [">= 2.4.1", "< 3.0.0"])
    s.add_runtime_dependency(%q<puppetlabs_spec_helper>.freeze, [">= 2.9.0", "< 3.0.0"])
    s.add_runtime_dependency(%q<rainbow>.freeze, ["~> 2.0"])
    s.add_runtime_dependency(%q<rspec-puppet>.freeze, [">= 2.3.2", "< 3.0.0"])
    s.add_runtime_dependency(%q<rspec-puppet-facts>.freeze, ["~> 1.9.5"])
    s.add_runtime_dependency(%q<rubocop>.freeze, ["~> 0.49.0"])
    s.add_runtime_dependency(%q<rubocop-i18n>.freeze, ["~> 1.2.0"])
    s.add_runtime_dependency(%q<rubocop-rspec>.freeze, ["~> 1.16.0"])
    s.add_runtime_dependency(%q<rspec_junit_formatter>.freeze, ["~> 0.2"])
    s.add_runtime_dependency(%q<serverspec>.freeze, ["~> 2.41"])
    s.add_runtime_dependency(%q<simplecov-console>.freeze, ["~> 0.4.2"])
    s.add_runtime_dependency(%q<specinfra>.freeze, ["= 2.77.1"])
  else
    s.add_dependency(%q<puppet_litmus>.freeze, [">= 0.4.0", "< 1.0.0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0.14.1", "< 1.0.0"])
    s.add_dependency(%q<puppet-blacksmith>.freeze, [">= 3.4.0"])
    s.add_dependency(%q<activesupport>.freeze, [">= 5.0.0", "< 6.0.0"])
    s.add_dependency(%q<codecov>.freeze, ["~> 0.1.10"])
    s.add_dependency(%q<dependency_checker>.freeze, ["~> 0.2"])
    s.add_dependency(%q<facterdb>.freeze, ["~> 0.8.1"])
    s.add_dependency(%q<gettext-setup>.freeze, ["~> 0.26"])
    s.add_dependency(%q<metadata-json-lint>.freeze, [">= 2.0.2", "< 3.0.0"])
    s.add_dependency(%q<mocha>.freeze, [">= 1.0.0", "< 1.2.0"])
    s.add_dependency(%q<parallel_tests>.freeze, [">= 2.14.1", "< 2.14.3"])
    s.add_dependency(%q<parser>.freeze, ["~> 2.5.1.2"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.10.4"])
    s.add_dependency(%q<puppet-lint>.freeze, [">= 2.3.0", "< 3.0.0"])
    s.add_dependency(%q<puppet_pot_generator>.freeze, ["~> 1.0"])
    s.add_dependency(%q<puppet-strings>.freeze, ["~> 2.0"])
    s.add_dependency(%q<puppet-resource_api>.freeze, ["~> 1.6"])
    s.add_dependency(%q<puppet-syntax>.freeze, [">= 2.4.1", "< 3.0.0"])
    s.add_dependency(%q<puppetlabs_spec_helper>.freeze, [">= 2.9.0", "< 3.0.0"])
    s.add_dependency(%q<rainbow>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rspec-puppet>.freeze, [">= 2.3.2", "< 3.0.0"])
    s.add_dependency(%q<rspec-puppet-facts>.freeze, ["~> 1.9.5"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.49.0"])
    s.add_dependency(%q<rubocop-i18n>.freeze, ["~> 1.2.0"])
    s.add_dependency(%q<rubocop-rspec>.freeze, ["~> 1.16.0"])
    s.add_dependency(%q<rspec_junit_formatter>.freeze, ["~> 0.2"])
    s.add_dependency(%q<serverspec>.freeze, ["~> 2.41"])
    s.add_dependency(%q<simplecov-console>.freeze, ["~> 0.4.2"])
    s.add_dependency(%q<specinfra>.freeze, ["= 2.77.1"])
  end
end
