module Ingreedy

  class UnitParser < Parslet::Parser
    include CaseInsensitiveParser

    rule(:unit) do
      UnitVariationMapper.all_variations.map { |variation|
        str(variation) | stri(variation)
      }.reduce(:|)
    end

    root :unit

  end

end
