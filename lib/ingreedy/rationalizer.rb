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
      if Ingreedy.preserve_amounts
        (normalized_word || compound_fraction || @float || @integer)
      else
        (normalized_word || rationalized_fraction || rationalized_float || @integer).to_r
      end
    end

    private

    def normalized_word
      return unless @word
      Ingreedy.dictionaries.current.numbers[@word.downcase]
    end

    def normalized_fraction
      @fraction.tap do |fraction|
        Ingreedy.dictionaries.current.vulgar_fractions.each do |char, amount|
          fraction.gsub!(char, amount.to_s)
        end
      end
    end

    def rationalized_fraction
      return unless @fraction
      result = normalized_fraction
      result = result.to_r + @integer.to_i
      result
    end

    def compound_fraction
      return unless @fraction
      "#{@integer} #{normalized_fraction}".strip
    end

    def rationalized_float
      return unless @float
      @float.tr(",", ".")
    end
  end
end
