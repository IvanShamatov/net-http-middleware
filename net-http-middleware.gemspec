# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'net/http/middleware/version'

Gem::Specification.new do |spec|
  spec.name          = 'net-http-middleware'
  spec.version       = Net::Http::Middleware::VERSION
  spec.authors       = ['Ivan Shamatov']
  spec.email         = ['status.enable@gmail.com']

  spec.summary       = 'Middleware-available Net::HTTP monkey patch'
  spec.description   = 'Implementation of `chain of responsibility`-pattern for Net::HTTP request method.'
  spec.homepage      = 'https://github.com/IvanShamatov/net-http-middleware'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
