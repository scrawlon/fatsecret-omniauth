# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "omniauth-fatsecret"
  s.version     = OmniAuth::Fatsecret::VERSION
  s.authors     = ["Scott McGrath"]
  s.email       = ["acid64k@yahoo.com"]
  s.homepage    = "https://github.com/scrawlon/omniauth-fatsecret"
  s.summary     = %q{OmniAuth strategy for FatSecret}
  s.description = %q{OmniAuth strategy for FatSecret}

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_runtime_dependency 'omniauth-oauth', '~> 1.0'
  s.add_runtime_dependency 'multi_json'

  s,add_development_dependency "rspec"
end
