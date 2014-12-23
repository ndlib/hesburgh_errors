$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hesburgh_errors/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hesburgh_errors"
  s.version     = HesburghErrors::VERSION
  s.authors     = ["Jon"]
  s.email       = ["jhartzle@nd.edu"]
  s.homepage    = "http://library.nd.edu"
  s.summary     = "Error trapping for our various apps."
  s.description = "Error traping."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0.4"
  s.add_dependency 'state_machine'
end
