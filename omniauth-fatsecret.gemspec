# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "omniauth-fatsecret/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "omniauth-fatsecret"
  s.version     = OmniAuth::Fatsecret::VERSION
  s.authors     = ["Scott McGrath"]
  s.email       = ["acid64k@yahoo.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of OmniauthFatsecret."
  s.description = "TODO: Description of OmniauthFatsecret."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.14"

  s.add_runtime_dependency 'omniauth-oauth', '~> 1.0'
  s.add_runtime_dependency 'multi_json'
 
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "httplog"
end
