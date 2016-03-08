module Ingreedy
  class Rationalizer
    def self.rationalize(options)
      new(options).rationalize
    end

    def initialize(options)
      @integer  = options.fetch(:integer, nil)
      @float    = options.fetch(:float, nil)
      @fraction = options.fetch(:fraction, nil)
      @word     = options.fetch(:word, nil)
    end

    def rationalize
      if @word
        result = normalized_word
      elsif @fraction
        result = rationalized_fraction
      elsif @integer
        result = @integer
      elsif @float
        result = rationalized_float
      end

      result.to_r
    end

    private

    def normalized_word
      Ingreedy.dictionaries.current.numbers[@word.downcase]
    end

    def normalized_fraction
      @fraction.tap do |fraction|
        vulgar_fractions.each do |char, amount|
          fraction.gsub!(char, amount.to_s)
        end
      end
    end

    def vulgar_fractions
      Ingreedy.dictionaries.current.vulgar_fractions
    end

    def rationalized_fraction
      result = normalized_fraction
      result = result.to_r + @integer.to_i if @integer
      result
    end

    def rationalized_float
      @float.tr(",", ".")
    end
  end
end
