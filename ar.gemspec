# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ar/version'

Gem::Specification.new do |spec|
  spec.name          = "ar"
  spec.version       = Ar::VERSION
  spec.authors       = ["Rachid Calazans"]
  spec.email         = ["rachidcalazans@gmail.com"]
  spec.summary       = %q{Write a short summary. Required.}
  spec.description   = %q{Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3.0"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "sqlite3", "~> 1.3.3"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "pry"


end
