# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bluedart/version'

Gem::Specification.new do |spec|
  spec.name          = "bluedart"
  spec.version       = Bluedart::VERSION
  spec.authors       = ["CJ"]
  spec.email         = ["chirag7jain@gmail.com"]

  spec.summary       = %q{Bluedart Web Services}
  spec.description   = %q{Provides an interface to Bluedart Web Services}
  spec.homepage      = "https://github.com/chirag7jain/bluedart"
  spec.licenses      = ["MIT"]

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'nokogiri', ">= 1.5.11"
  spec.add_dependency 'httparty', ">= 0.13.5"
  spec.add_dependency 'nori', ">= 2.4.0"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  
  spec.required_ruby_version = ">= 1.9.3"
end
