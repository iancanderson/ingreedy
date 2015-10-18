module Ingreedy
  class UnitVariationMapper
    def self.regexp
      regexp_string = all_variations.map { |v| Regexp.escape(v) }.join("|")
      Regexp.new(regexp_string, Regexp::IGNORECASE)
    end

    def self.all_variations
      # Return these in order of size, descending
      # That way, the longer versions will try to be parsed first,
      # then the shorter versions
      # e.g. so '1 cup flour' will be parsed as 'cup' instead of 'c'
      variations_map.values.flatten.sort { |a, b| b.length <=> a.length }
    end

    def self.unit_from_variation(variation)
      return if variations_map.empty?

      hash_entry_as_array = variations_map.detect do |_unit, variations|
        variations.include?(variation)
      end

      if hash_entry_as_array
        hash_entry_as_array.first
      else
        # try again with the variation downcased
        # (hack to deal with the abbreviations for teaspoon and tablespoon)
        hash_entry_as_array = variations_map.detect do |_unit, variations|
          variations.include?(variation.downcase)
        end
        hash_entry_as_array.first
      end
    end

    def self.variations_map
      Ingreedy.dictionaries.current.units
    end
  end
end
