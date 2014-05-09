# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chimpy/version'

Gem::Specification.new do |spec|
  spec.name          = "Chimpy"
  spec.version       = Chimpy::VERSION
  spec.authors       = ["Ignacio Gutierrez"]
  spec.email         = ["nachojgutierrez@gmail.com"]
  spec.summary       = %q{Chimpy syncs your users from your DB to your respective lists in MailChimp.}
  spec.description   = %q{Chimpy syncs your users from your DB to your respective lists in MailChimp.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
