path = File.expand_path(File.join(File.dirname(__FILE__), 'ingreedy'))

require File.join(path, 'case_insensitive_parser')
require File.join(path, 'ingreedy_parser')
require File.join(path, 'dictionary_collection')

module Ingreedy
  class << self
    attr_accessor :locale

    def parse(query)
      parser = Parser.new(query)
      parser.parse
    end

    def dictionaries
      @dictionaries ||= DictionaryCollection.new
    end
  end
end
