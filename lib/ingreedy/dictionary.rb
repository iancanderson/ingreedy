module Ingreedy
  class Dictionary
    attr_reader :units, :numbers, :prepositions

    def initialize(entries = {})
      @units = entries[:units] || raise('No units found in dictionary')
      @numbers = entries[:numbers] || {}
      @prepositions = entries[:prepositions] || []
    end
  end
end
