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

  s.files = `git ls-files`.split("\n")
  s.require_path = "lib"

  s.add_dependency "parslet", ">= 1.7.0", "< 3"

  s.add_development_dependency "rake", "~> 13"
  s.add_development_dependency "rspec", "~> 3.10"
  s.add_development_dependency "coveralls_reborn", "~> 0.22"
  s.add_development_dependency "pry"
end
