require File.expand_path("../lib/ingreedy/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "ingreedy"
  s.version     = Ingreedy::VERSION
  s.licenses    = ["MIT"]
  s.authors     = ["Ian C. Anderson"]
  s.email       = ["ian@iancanderson.com"]

  s.summary     = "Recipe parser"
  s.description = <<-MSG
    Natural language recipe ingredient parser that supports numeric amount,
    units, and ingredient
  MSG
  s.homepage = "http://github.com/iancanderson/ingreedy"

  s.add_dependency "parslet", "~> 1.7.0", ">= 1.7.0"

  s.add_development_dependency "rake", "~> 0.9", ">= 0.9"
  s.add_development_dependency "rspec", "~> 3.3.0", ">= 3.3.0"
  s.add_development_dependency "coveralls", "~> 0.7.0", ">= 0.7.0"
  s.add_development_dependency "pry"
  s.files = Dir.glob("lib/**/*.rb")
end
