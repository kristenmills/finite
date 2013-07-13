# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'finite/version'

Gem::Specification.new do |spec|
  spec.name          = "finite"
  spec.version       = Finite::VERSION
  spec.authors       = ["Kristen Mills"]
  spec.email         = ["kristen@kristen-mills.com"]
  spec.description   = %q{A simple state machine implementation for ruby}
  spec.summary       = %q{A simple state machine implementation for ruby}
  spec.homepage      = "http://github.com/kristenmills/finite"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "rspec"
end
