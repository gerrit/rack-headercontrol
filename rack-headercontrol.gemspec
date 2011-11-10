# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/headercontrol"

Gem::Specification.new do |s|
  s.name        = "rack-headercontrol"
  s.version     = Rack::Headercontrol::VERSION
  s.authors     = ["Gerrit Kaiser"]
  s.email       = ["gerrit@gerritkaiser.de"]
  s.homepage    = 'http://github.com/gerrit/rack-headercontrol'
  s.summary     = 'Rack Middleware that allows you set/override response headers for selected paths'
  s.description = 'Can be used e.g. to set CORS headers or selective caching of resources'

  s.rubyforge_project = 'rack-headercontrol'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # s.add_development_dependency "rspec"
  s.add_runtime_dependency 'rack'
end
