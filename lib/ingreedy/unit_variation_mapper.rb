module Ingreedy
  class UnitVariationMapper

    def self.regexp
      regexp = all_variations.map { |v| Regexp.escape(v) }.join('|')
      regexp = Regexp.new(regexp, Regexp::IGNORECASE)
    end

    def self.all_variations
      # Return these in order of size, descending
      # That way, the longer versions will try to be parsed first, then the shorter versions
      # e.g. so '1 cup flour' will be parsed as 'cup' instead of 'c'
      variations_map.values.flatten.sort { |a, b| b.length <=> a.length }
    end

    def self.unit_from_variation(variation)
      return if variations_map.empty?
      hash_entry_as_array = variations_map.detect { |unit, variations| variations.include?(variation) }

      if hash_entry_as_array
        hash_entry_as_array.first
      else
        # try again with the variation downcased
        # this is a hacky way to deal with the abbreviations for teaspoon and tablespoon
        hash_entry_as_array = variations_map.detect { |unit, variations| variations.include?(variation.downcase) }
        hash_entry_as_array.first
      end
    end

    private

    def self.variations_map
      Ingreedy.dictionaries.current.units
    end
  end
end
