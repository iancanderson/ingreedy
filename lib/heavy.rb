path = File.expand_path(File.join(File.dirname(__FILE__), 'heavy'))

require File.join(path, 'unit_parser')

module Heavy
  class << self
    def parse(query)
      h = UnitParser.new(query)
      h.parse
      h
    end
  end
end