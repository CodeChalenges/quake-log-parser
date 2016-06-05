# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = "quake-log-parser"
  spec.version       = QuakeVersion::VERSION
  spec.authors       = ["Mauricio Klein"]
  spec.email         = ["mauricio.klein.msk@gmail.com"]
  spec.description   = %q{A Quake log parser, written in Ruby}
  spec.summary       = %q{Generates informations collected from a Quake log file}
  spec.homepage      = "https://bitbucket.org/mauricioklein/quake-log-parser"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "simplecov", "~> 0.11"
  spec.add_development_dependency "rubocop", "~> 0.40"

  spec.add_runtime_dependency "hmap", "~> 0.1"
end
