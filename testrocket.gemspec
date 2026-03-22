# -*- encoding: utf-8 -*-
require_relative 'lib/testrocket'

Gem::Specification.new do |s|
  s.name        = 'testrocket'
  s.version     = TestRocket::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Peter Cooper', 'Christoph Grabo']
  s.email       = %w[git@peterc.org chris@dinarrr.com]
  s.homepage    = 'https://github.com/peterc/testrocket'
  s.summary     = %q{A super lightweight lambda-based testing library for Ruby}
  s.description = %q{A super lightweight lambda-based testing library for Ruby}
  s.license     = 'MIT'
  s.required_ruby_version = '>= 2.1'

  s.files         = Dir.glob('{lib,test}/**/*') + %w[README.md LICENSE Gemfile testrocket.gemspec]
  s.executables   = Dir.glob('bin/*').map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
end
