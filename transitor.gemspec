# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'transitor/version'

Gem::Specification.new do |spec|
  spec.name          = "transitor"
  spec.version       = Transitor::VERSION
  spec.authors       = ["Dan Draper"]
  spec.email         = ["dan@codehire.com"]

  spec.summary       = %q{A simple object driven, framework agnostic state machine}
  spec.description   = %q{Use POROs for your statemachines. Easily define custom transitions, guards and guard messages.}
  spec.homepage      = "https://github.com/coderdan/transitor"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "activerecord"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "byebug"
end
