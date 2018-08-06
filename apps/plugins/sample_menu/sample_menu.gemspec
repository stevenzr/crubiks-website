$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sample_menu/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sample_menu"
  s.version     = SampleMenu::VERSION
  s.authors     = ["steven"]
  s.email       = [""]
  s.homepage    = ""
  s.summary     = ": Summary of SampleMenu."
  s.description = ": Description of SampleMenu."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"

  s.add_development_dependency "sqlite3"
end
