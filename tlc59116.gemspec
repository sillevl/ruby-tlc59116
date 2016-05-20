# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tlc59116/version'

Gem::Specification.new do |spec|
  spec.name          = "tlc59116"
  spec.version       = Tlc59116::VERSION
  spec.authors       = ["Sille Van Landschoot"]
  spec.email         = ["info@sillevl.be"]

  spec.summary       = %q{Driver for TLC59116 led driver using I2C}
  spec.description   = %q{Driver for TLC59116 led driver using I2C}
  spec.homepage      = "https://github.com/sillevl/ruby-tlc59116"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency "i2c", "~> 0.4"
end
