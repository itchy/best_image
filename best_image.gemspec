# -*- encoding: utf-8 -*-
require File.expand_path('../lib/best_image/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Scott Johnson"]
  gem.email         = ["7.scott.j@gmail.com"]
  gem.description   = %q{Returns the *Best Image* found from a passed url}
  gem.summary       = %q{This gem scrapes a passed web page and returns the url of the *best image* found on that page.}
  gem.homepage      = ""

  gem.add_development_dependency "rspec"
  gem.add_dependency('image_size', '>= 1.1.1')
  gem.add_dependency('nokogiri', '>= 1.5.2')
  # gem.add_dependency('net/http')

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "best_image"
  gem.require_paths = ["lib"]
  gem.version       = BestImage::VERSION
end
