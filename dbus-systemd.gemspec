# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dbus/systemd/version'

Gem::Specification.new do |spec|
  spec.name          = "dbus-systemd"
  spec.version       = DBus::Systemd::VERSION
  spec.authors       = ["Nathan Williams"]
  spec.email         = ["nath.e.will@gmail.com"]

  spec.summary       = 'library for interfacing with systemd over dbus'
  spec.description   = IO.read(File.join(File.dirname(__FILE__), 'README.md'))
  spec.homepage      = "https://github.com/nathwill/ruby-dbus-systemd"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "ruby-dbus", "~> 0.13"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
