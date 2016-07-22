# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'baidu_geocoder/version'

Gem::Specification.new do |spec|
  spec.name          = "baidu_geocoder"
  spec.version       = BaiduGeocoder::VERSION
  spec.authors       = ["RubyCat"]
  spec.email         = ["chenxueping1819@gmail.com"]

  spec.summary       = %q{Geocoder by Baidu Map}
  spec.description   = %q{Geocoder by Baidu Map}
  spec.homepage      = "https://github.com/a598799539/baidu_geocoder"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "http", "~> 2.0"
end
