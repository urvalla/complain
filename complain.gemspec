# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'complain/version'

Gem::Specification.new do |spec|
  spec.name          = "complain"
  spec.version       = Complain::VERSION
  spec.authors       = ["Roman"]
  spec.email         = ["urvala@gmail.com"]

  spec.summary       = %q{Complain - simple exception to logs writer.}
  spec.description   = %q{Complain can output exceptions to stderr, stdout, loggers with single-line call.}
  spec.homepage      = "https://github.com/appelsin/complain"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
