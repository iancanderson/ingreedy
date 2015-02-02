module Ingreedy

  class UnitParser < Parslet::Parser
    include CaseInsensitiveParser

    rule(:unit) do
      unit_variations.map { |var| str(var) | stri(var) }.reduce(:|)
    end

    root :unit

    private

    def unit_variations
      UnitVariationMapper.all_variations
    end

  end

end
