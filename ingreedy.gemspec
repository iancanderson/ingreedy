require File.expand_path('../lib/ingreedy/version', __FILE__)

Gem::Specification.new do |s|
 s.name        = "ingreedy"
 s.version     = Ingreedy::VERSION
 s.authors     = ["Ian C. Anderson"]
 s.email       = ["anderson.ian.c@gmail.com"]

 s.summary     = "Recipe parser"
 s.description = "Natural language recipe ingredient parser that supports numeric amount, units, and ingredient"
 s.homepage    = "http://github.com/iancanderson/ingreedy"

 s.files       = Dir.glob("lib/**/*.rb")
end
