module Ingreedy
  class Dictionary
    attr_reader :units, :numbers, :prepositions

    def initialize(units: {}, numbers: {}, prepositions: [])
      @units, @numbers, @prepositions = units, numbers, prepositions
      raise 'No units found in dictionary' if @units.empty?
    end
  end
end
