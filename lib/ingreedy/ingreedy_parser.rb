require 'parslet'

require_relative 'amount_parser'
require_relative 'rationalizer'
require_relative 'unit_variation_mapper'

module Ingreedy

  class Parser < Parslet::Parser

    attr_reader :original_query
    Result = Struct.new(:amount, :unit, :container_amount, :container_unit, :ingredient, :original_query)

    rule(:range) do
      AmountParser.new.as(:amount) >>
      whitespace.maybe >>
      str('-') >>
      whitespace.maybe >>
      AmountParser.new.as(:amount_end)
    end

    rule(:amount) do
      AmountParser.new.as(:amount)
    end

    rule(:whitespace) do
      match("\s")
    end

    rule(:container_amount) do
      AmountParser.new
    end

    rule(:unit) do
      if unit_matches.any?
        unit_matches.map { |u| str(u) }.inject(:|)
      else
        str('')
      end
    end

    rule(:container_unit) do
      unit
    end

    rule(:unit_and_preposition) do
      unit.as(:unit) >> (preposition_or_whitespace | any.absent?)
    end

    rule(:preposition_or_whitespace) do
      if prepositions.empty?
        whitespace
      else
        preposition | whitespace
      end
    end

    rule(:preposition) do
      whitespace >>
      prepositions.map { |con| str(con) }.inject(:|) >>
      whitespace
    end

    rule(:amount_unit_separator) do
      whitespace | str('-')
    end

    rule(:container_size) do
      # e.g. (12 ounce) or 12 ounce
      str('(').maybe >>
      container_amount.as(:container_amount) >>
      amount_unit_separator.maybe >>
      container_unit.as(:container_unit) >>
      str(')').maybe >> preposition_or_whitespace
    end

    rule(:amount_and_unit) do
      (range | amount) >>
      whitespace.maybe >>
      unit_and_preposition.maybe >>
      container_size.maybe
    end

    rule(:quantity) do
      amount_and_unit | unit_and_preposition
    end

    rule(:standard_format) do
      # e.g. 1/2 (12 oz) can black beans
      quantity >> any.repeat.as(:ingredient)
    end

    rule(:reverse_format) do
      # e.g. flour 200g
      ((whitespace >> quantity).absent? >> any).repeat.as(:ingredient) >> whitespace >> quantity
    end

    rule(:ingredient_addition) do
      standard_format | reverse_format
    end

    root :ingredient_addition

    def initialize(original_query)
      @original_query = original_query
    end

    def parse
      result = Result.new
      result[:original_query] = original_query

      parslet = super(original_query)

      result[:amount] = rationalize parslet[:amount]
      result[:amount] = [result[:amount], rationalize(parslet[:amount_end])] if parslet[:amount_end]
      result[:container_amount] = rationalize(parslet[:container_amount])

      result[:unit] = convert_unit_variation_to_canonical(parslet[:unit].to_s) if parslet[:unit]
      result[:container_unit] = convert_unit_variation_to_canonical(parslet[:container_unit].to_s) if parslet[:container_unit]

      result[:ingredient] = parslet[:ingredient].to_s.lstrip.rstrip #TODO cheating

      result
    end

    private

    def unit_matches
      @unit_matches ||= original_query.scan(UnitVariationMapper.regexp).sort_by(&:length).reverse
    end

    def prepositions
      Ingreedy.dictionaries.current.prepositions
    end

    def convert_unit_variation_to_canonical(unit_variation)
      UnitVariationMapper.unit_from_variation(unit_variation)
    end

    def rationalize(amount)
      return unless amount
      integer = amount[:integer_amount]
      integer &&= integer.to_s

      float = amount[:float_amount]
      float &&= float.to_s

      fraction = amount[:fraction_amount]
      fraction &&= fraction.to_s

      word = amount[:word_integer_amount]
      word &&= word.to_s

      Rationalizer.rationalize(
        integer:  integer,
        float:    float,
        fraction: fraction,
        word:     word
      )
    end
  end
end
