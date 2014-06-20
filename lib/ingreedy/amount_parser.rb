require 'parslet'
require 'numbers_in_words'

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
      str('.') >> integer
    end

    rule(:fraction) do
      (integer.as(capture_key(:integer_amount)) >> whitespace).maybe >>
      (integer >> match('/') >> integer).as(capture_key(:fraction_amount))
    end

    rule(:english_digit) do
      english_digits.map { |d| stri(d) }.inject(:|)
    end

    rule(:amount) do
      fraction |
        float.as(capture_key(:float_amount)) |
        integer.as(capture_key(:integer_amount)) |
        english_digit.as(capture_key(:word_integer_amount))
    end

    root(:amount)

    private

    def english_digits
      (1..12).map do |n|
        NumbersInWords::ToWord.new(
          n, NumbersInWords.language
        ).in_words
      end
    end

  end


end
