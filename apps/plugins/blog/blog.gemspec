$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blog/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blog"
  s.version     = Blog::VERSION
  s.authors     = ["dpch"]
  s.email       = ["dian.chandra@crubiks.com"]
  s.homepage    = ""
  s.summary     = ": Summary of Blog."
  s.description = ": Description of Blog."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "camaleon_cms", "~> 2.0"

  s.add_development_dependency "sqlite3"
end
