module Ingreedy
  class Dictionary
    attr_reader :units, :numbers, :prepositions, :range_separators
    attr_reader :imprecise_amounts

    def initialize(units:, numbers: {}, prepositions: [], range_separators: %w{- ~}, imprecise_amounts: [])
      @units = units
      @numbers = sort_by_length(numbers)
      @prepositions = prepositions
      @range_separators = range_separators
      @imprecise_amounts = imprecise_amounts
    end

    # https://en.wikipedia.org/wiki/Number_Forms
    def vulgar_fractions
      {
        "\u00BC" => "1/4",
        "\u00BD" => "1/2",
        "\u00BE" => "3/4",
        "\u2150" => "1/7",
        "\u2151" => "1/9",
        "\u2152" => "1/10",
        "\u2153" => "1/3",
        "\u2154" => "2/3",
        "\u2155" => "1/5",
        "\u2156" => "2/5",
        "\u2157" => "3/5",
        "\u2158" => "4/5",
        "\u2159" => "1/6",
        "\u215A" => "5/6",
        "\u215B" => "1/8",
        "\u215C" => "3/8",
        "\u215D" => "5/8",
        "\u215E" => "7/8",
      }
    end

    private

      def sort_by_length(hash)
        hash.sort_by { |key, val| -key.length }.to_h
      end
  end
end
