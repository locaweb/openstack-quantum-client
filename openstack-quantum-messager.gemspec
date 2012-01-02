# -*- encoding: utf-8 -*-
require File.expand_path('../lib/openstack-quantum-messager/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "openstack-quantum-messager"
  gem.version       = Quantum::Messager::VERSION
  gem.authors       = ["PotHix"]
  gem.email         = ["pothix@pothix.com"]
  gem.description   = %q{A simple gem to deal with openstack quantum}
  gem.summary       = %q{The main objective of this gem is to deal easily with openstack quantum}
  gem.homepage      = "http://www.locaweb.com.br"

  gem.files         = Dir["./**/*"].reject {|file| file =~ /\.git|pkg/}
  gem.require_paths = ["lib"]

  gem.add_dependency "httparty"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "fakeweb"
end
