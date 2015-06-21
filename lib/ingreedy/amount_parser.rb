require 'parslet'

module Ingreedy

  class AmountParser < Parslet::Parser
    include CaseInsensitiveParser

    def initialize(options = {})
      @key_prefix = options[:key_prefix] ? "#{options[:key_prefix]}_" : ''
    end

    def capture_key(key)
      (@key_prefix + key.to_s).to_sym
    end

    rule(:whitespace) do
      match("\s")
    end

    rule(:integer) do
      match('[0-9]').repeat(1)
    end

    rule(:float) do
      integer.maybe >>
      float_delimiter >> integer
    end

    rule(:float_delimiter) do
      str(',') | str('.')
    end

    rule(:fraction) do
      (integer.as(capture_key(:integer_amount)) >> whitespace).maybe >>
      (integer >> match('/') >> integer).as(capture_key(:fraction_amount))
    end

    rule(:word_digit) do
      word_digits.map { |d| stri(d) }.inject(:|) || any
    end

    rule(:amount_unit_separator) do
      whitespace | str('-')
    end

    rule(:amount) do
      fraction |
      float.as(capture_key(:float_amount)) |
      integer.as(capture_key(:integer_amount)) |
      word_digit.as(capture_key(:word_integer_amount)) >> amount_unit_separator
    end

    root(:amount)

    private

    def word_digits
      Ingreedy.dictionaries.current.numbers.keys
    end

  end


end
