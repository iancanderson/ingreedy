path = File.expand_path(File.join(File.dirname(__FILE__), "ingreedy"))

require File.join(path, "case_insensitive_parser")
require File.join(path, "ingreedy_parser")
require File.join(path, "dictionary_collection")

module Ingreedy
  def self.locale
    @locale ||= nil
  end

  def self.locale=(locale)
    @locale = locale
  end

  def self.parse(query)
    parser = Parser.new(query)
    parser.parse
  end

  def self.dictionaries
    @dictionaries ||= DictionaryCollection.new
  end

  def self.current_dictionary
    dictionaries.current
  end
end
