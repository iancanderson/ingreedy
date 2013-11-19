module Ingreedy

  class UnitParser < Parslet::Parser
    rule(:unit) do
      UnitVariationMapper.all_variations.map { |variation|
        case_sensitive = str(variation)
        case_insensitive = variation.chars.map { |char|
          match "[#{char.upcase}#{char.downcase}]"
        }.reduce(:>>)

        case_sensitive | case_insensitive
      }.reduce(:|)
    end

    root :unit

  end

end
