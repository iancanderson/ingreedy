require 'parslet'

module Ingreedy

  class AmountParser < Parslet::Parser
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

    rule(:amount) do
      fraction | float.as(capture_key(:float_amount)) | integer.as(capture_key(:integer_amount))
    end

    root(:amount)

  end


end
