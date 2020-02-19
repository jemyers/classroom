# -*- encoding: utf-8 -*-
# stub: r10k 3.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "r10k".freeze
  s.version = "3.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Adrien Thebo".freeze]
  s.date = "2020-01-09"
  s.description = "    R10K provides a general purpose toolset for deploying Puppet environments and modules.\n    It implements the Puppetfile format and provides a native implementation of Puppet\n    dynamic environments.\n".freeze
  s.email = "adrien@somethingsinistral.net".freeze
  s.executables = ["r10k".freeze]
  s.files = ["bin/r10k".freeze]
  s.homepage = "https://github.com/puppetlabs/r10k".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Puppet environment and module deployment".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<colored2>.freeze, ["= 3.1.2"])
    s.add_runtime_dependency(%q<cri>.freeze, ["= 2.15.6"])
    s.add_runtime_dependency(%q<log4r>.freeze, ["= 1.1.10"])
    s.add_runtime_dependency(%q<multi_json>.freeze, ["~> 1.10"])
    s.add_runtime_dependency(%q<puppet_forge>.freeze, ["~> 2.3.0"])
    s.add_runtime_dependency(%q<gettext-setup>.freeze, ["~> 0.24"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.1"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<yard>.freeze, ["~> 0.9.11"])
    s.add_development_dependency(%q<minitar>.freeze, ["~> 0.9.0"])
  else
    s.add_dependency(%q<colored2>.freeze, ["= 3.1.2"])
    s.add_dependency(%q<cri>.freeze, ["= 2.15.6"])
    s.add_dependency(%q<log4r>.freeze, ["= 1.1.10"])
    s.add_dependency(%q<multi_json>.freeze, ["~> 1.10"])
    s.add_dependency(%q<puppet_forge>.freeze, ["~> 2.3.0"])
    s.add_dependency(%q<gettext-setup>.freeze, ["~> 0.24"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.1"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9.11"])
    s.add_dependency(%q<minitar>.freeze, ["~> 0.9.0"])
  end
end
