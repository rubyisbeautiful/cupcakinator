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
  gem.license       = 'MIT'

  gem.add_dependency 'hashie', '>= 2.0.0'

end
