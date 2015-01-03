# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ssv/version'

Gem::Specification.new do |spec|
  spec.name          = "ssv"
  spec.version       = SSV::VERSION
  spec.authors       = ["Stephen Key"]
  spec.email         = ["stephenkey123@gmail.com"]
  spec.summary       = %q{SSV is a Ruby Gem to import and sort symbol delimited files.}
  spec.description   = %q{SSV is a Ruby Gem to import and sort symbol delimited files.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
