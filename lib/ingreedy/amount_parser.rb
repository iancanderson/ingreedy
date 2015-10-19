require "parslet"

module Ingreedy
  class AmountParser < Parslet::Parser
    include CaseInsensitiveParser

    rule(:whitespace) do
      match("\s")
    end

    rule(:integer) do
      match("[0-9]").repeat(1)
    end

    rule(:float) do
      integer.maybe >>
        float_delimiter >> integer
    end

    rule(:float_delimiter) do
      str(",") | str(".")
    end

    rule(:fraction) do
      compound_simple_fraction | compound_vulgar_fraction
    end

    rule(:compound_simple_fraction) do
      (integer.as(:integer_amount) >> whitespace).maybe >>
        simple_fraction.as(:fraction_amount)
    end

    rule(:simple_fraction) do
      integer >> match("/") >> integer
    end

    rule(:compound_vulgar_fraction) do
      (integer.as(:integer_amount) >> whitespace.maybe).maybe >>
        vulgar_fraction.as(:fraction_amount)
    end

    rule(:vulgar_fraction) do
      vulgar_fractions.map { |f| str(f) }.inject(:|)
    end

    rule(:word_digit) do
      word_digits.map { |d| stri(d) }.inject(:|) || any
    end

    rule(:amount_unit_separator) do
      whitespace | str("-")
    end

    rule(:amount) do
      fraction |
        float.as(:float_amount) |
        integer.as(:integer_amount) |
        word_digit.as(:word_integer_amount) >> amount_unit_separator
    end

    root(:amount)

    def initialize(options = {})
      @dictionary = options.fetch(:dictionary, Ingreedy.current_dictionary)
    end

    private

    attr_reader :dictionary

    def word_digits
      dictionary.numbers.keys
    end

    def vulgar_fractions
      dictionary.vulgar_fractions.keys
    end
  end
end
