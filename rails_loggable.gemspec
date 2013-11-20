$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_loggable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_loggable"
  s.version     = RailsLoggable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Breno Perucchi", "Co-Author: Vinicius Horewicz"]
  s.email       = ["bperucchi@gmail.com"]
  s.summary     = "Track changes of activerecord and generate a history"
  s.description = s.summary
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
  s.require_paths = ['lib']

  s.add_dependency "rails", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
end
