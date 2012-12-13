# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'testament/version'

Gem::Specification.new do |gem|
  gem.name          = "test_timer"
  gem.version       = Testament::VERSION
  gem.authors       = ["Hashrocket Workstation"]
  gem.email         = ["dev@hashrocket.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.add_development_dependency 'rspec', '>= 2.11.0'
  gem.add_development_dependency 'pry'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
