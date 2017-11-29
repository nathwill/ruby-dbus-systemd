# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dbus/systemd/version'

Gem::Specification.new do |spec|
  spec.name          = 'dbus-systemd'
  spec.version       = DBus::Systemd::VERSION
  spec.authors       = ['Nathan Williams']
  spec.email         = ['nath.e.will@gmail.com']

  spec.summary       = 'systemd D-Bus API library'
  spec.description   = 'library for interfacing with systemd D-Bus APIs'
  spec.homepage      = 'https://github.com/nathwill/ruby-dbus-systemd'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'ruby-dbus', '~> 0.14'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'rubocop', '~> 0.51'
  spec.add_development_dependency 'yard', '~> 0.9'
end
