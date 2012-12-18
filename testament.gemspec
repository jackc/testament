# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'testament/version'

Gem::Specification.new do |gem|
  gem.name          = "testament"
  gem.version       = Testament::VERSION
  gem.authors       = ["Jack Christensen"]
  gem.email         = ["jack@jackchristensen.com"]
  gem.description   = %q{Time, record, and analyze test runs}
  gem.summary       = %q{Time, record, and analyze test runs}
  gem.homepage      = "https://github.com/JackC/testament"

  gem.add_dependency 'activesupport', '~> 3.2.9'
  gem.add_dependency 'sequel', '~> 3.42.0'
  gem.add_dependency 'sqlite3', '~> 1.3.6'
  gem.add_dependency 'terminal-table', '~> 1.4.5'
  gem.add_dependency 'thor', '~> 0.16.0'

  gem.add_development_dependency 'rspec', '>= 2.11.0'
  gem.add_development_dependency 'pry'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
