# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'posty_cli/version'

Gem::Specification.new do |gem|
  gem.name = "posty_cli"
  gem.version = PostyCli::VERSION
  gem.authors = ["Thomas Berendt", "Florian Schmidhuber"]
  gem.email = ["team@posty-soft.de"]
  gem.description = %q{Posty Command Line Tool}
  gem.summary = %q{This tool brings the functionality of the Posty Administration tool to the command line}
  gem.homepage = "https://github.com/posty/posty_cli"
  gem.license = "LGPL v3"
  gem.files = Dir["**/*"]
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "thor"
  gem.add_runtime_dependency "json"
  gem.add_runtime_dependency "rest-client"
end
