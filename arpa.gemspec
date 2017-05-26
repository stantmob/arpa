# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arpa/version'

Gem::Specification.new do |spec|
  spec.name          = "arpa"
  spec.version       = Arpa::VERSION
  spec.authors       = ["Rachid Calazans"]
  spec.summary       = "Authorization Gem for Ruby and Ruby on Rails projects"
  spec.email         = ["rachidcalazans@gmail.com"]
  spec.license       = "MIT"
  spec.homepage      = "https://github.com/rachidcalazans/arpa"
  spec.description   = "Authorization Gem for Ruby and Ruby on Rails projects"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.3', '>= 3.3.0'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'sqlite3', '~> 1.3', '>= 1.3.3'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'pry'

  spec.add_dependency 'activerecord', '>= 4.2.0'
  spec.add_dependency 'railties', '>= 4.2.0'

end
