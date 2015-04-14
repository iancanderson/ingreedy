require File.expand_path('../lib/ingreedy/version', __FILE__)

Gem::Specification.new do |s|
 s.name        = "ingreedy"
 s.version     = Ingreedy::VERSION
 s.authors     = ["Ian C. Anderson"]
 s.email       = ["anderson.ian.c@gmail.com"]

 s.summary     = "Recipe parser"
 s.description = "Natural language recipe ingredient parser that supports numeric amount, units, and ingredient"
 s.homepage    = "http://github.com/iancanderson/ingreedy"

 s.add_dependency 'parslet', '~> 1.7.0'

 s.add_development_dependency 'rake', '~> 0.9'
 s.add_development_dependency 'rspec', '~> 2.11.0'
 s.add_development_dependency 'coveralls', '~> 0.7.0'
 s.add_development_dependency 'pry'
 s.files       = Dir.glob("lib/**/*.rb")
end
