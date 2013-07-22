# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cupcakinator/version', __FILE__)
require 'base64'

Gem::Specification.new do |gem|
  gem.authors       = ["Bryan Taylor"]
  gem.email         = ['YmNwdGF5bG9yQGdtYWlsLmNvbQ==\n'].collect{ |foo| Base64.decode64(foo) }
  gem.description   = %q{ Add config from YAML to any class }
  gem.summary       = %q{ Easy to add config from YAML to any class }
  gem.homepage      = "http://github.com/rubyisbeautiful/cupcakinator"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cupcakinator"
  gem.require_paths = ["lib"]
  gem.version       = Cupcakinator::VERSION

  gem.add_runtime_dependency 'hashie'

  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "debugger"
  gem.add_development_dependency "guard"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "guard-spork"
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rb-readline'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency "yard"
  gem.add_development_dependency "redcarpet"




end
