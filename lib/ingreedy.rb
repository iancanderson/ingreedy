path = File.expand_path(File.join(File.dirname(__FILE__), 'ingreedy'))

require File.join(path, 'ingreedy_parser')

module Ingreedy
  class << self
    def parse(query)
      parser = IngreedyParser.new(query)
      parser.parse
      parser
    end
  end
end
