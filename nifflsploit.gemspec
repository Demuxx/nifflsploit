# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nifflsploit/version'

Gem::Specification.new do |gem|
  gem.name          = "nifflsploit"
  gem.version       = Nifflsploit::VERSION
  gem.authors       = ["Michael Carlson"]
  gem.email         = ["me@mbcarlson.org"]
  gem.description   = %q{ A tool for finding metasploit module information related to CVEs }
  gem.summary       = %q{ This gem allows searching for metasploit exploit modules for a given CVE. }
  gem.homepage      = "https://github.com/Prandium/nifflsploit"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version     = '>= 1.9.2'

  gem.add_development_dependency('rspec')
  gem.add_development_dependency('nokogiri')
end
