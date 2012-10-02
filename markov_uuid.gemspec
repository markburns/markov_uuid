# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'markov_uuid'

Gem::Specification.new do |gem|
  gem.name          = "markov_uuid"
  gem.version       = MarkovUuid::VERSION
  gem.authors       = ["Mark Burns"]
  gem.email         = ["markthedeveloper@gmail.com"]
  gem.description   = %q{People friendly readable UUIDs}
  gem.summary       = %q{Easily generate random English-like UUIDs (or any other language)
  that are more natural to convey to other people. E.g. over the phone, etc.}
  gem.homepage      = "http://github.com/markburns/markov_uuid"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
