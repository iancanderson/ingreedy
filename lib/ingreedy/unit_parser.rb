module Ingreedy

  class UnitParser < Parslet::Parser
    rule(:unit) do
      case_sensitive_unit | case_insensitive_unit
    end

    rule(:case_sensitive_unit) do
      UnitVariationMapper.all_variations.
        map { |variation|
          str(variation)
        }.reduce(:|)
    end

    rule(:case_insensitive_unit) do
      UnitVariationMapper.all_variations.
        map { |variation|
          variation.chars.map { |char|
            if char.upcase != char.downcase
              match "[#{char.upcase}#{char.downcase}]"
            else
              str(char)
            end
          }.reduce(:>>)
        }.reduce(:|)
    end

    root :unit

  end

end
