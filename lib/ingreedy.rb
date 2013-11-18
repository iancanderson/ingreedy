path = File.expand_path(File.join(File.dirname(__FILE__), 'ingreedy'))

require File.join(path, 'ingreedy_parser')

module Ingreedy
  class << self
    def parse(query)
      parser = Parser.new(query)
      parser.parse
    end
  end
end
