# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "testrocket/version"

Gem::Specification.new do |s|
  s.name        = "testrocket"
  s.version     = Testrocket::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Peter Cooper","Christoph Grabo"]
  s.email       = ["git@peterc.org","chris@dinarrr.com"]
  s.homepage    = "http://github.com/peterc/testrocket"
  s.summary     = %q{A super lightweight testing library for Ruby}
  s.description = %q{A super lightweight testing library for Ruby}

  s.rubyforge_project = "testrocket"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
