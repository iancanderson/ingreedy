module Ingreedy
  class UnitVariationMapper

    def self.all_variations
      # Return these in order of size, descending
      # That way, the longer versions will try to be parsed first, then the shorter versions
      # e.g. so '1 cup flour' will be parsed as 'cup' instead of 'c'
      @@all_variations ||= variations_map.keys.flatten.sort { |a, b| b.length <=> a.length }
    end

    def self.unit_from_variation(variation)
      hash_entry_as_array = variations_map.detect { |variations, unit| variations.include?(variation) }

      if hash_entry_as_array
        hash_entry_as_array.last
      else
        # try again with the variation downcased
        # this is a hacky way to deal with the abbreviations for teaspoon and tablespoon
        hash_entry_as_array = variations_map.detect { |variations, unit| variations.include?(variation.downcase) }
        hash_entry_as_array.last
      end
    end

    private

    def self.variations_map
      @@variations_map ||= build_variations_map
    end

    def self.build_variations_map
      #TODO prioritize the un-abbreviated versions
      {
        ['cups', 'cup', 'c.', 'c'] => :cup,
        ["fl. oz.", "fl oz", "fluid ounce", "fluid ounces"] => :fluid_ounce,
        ["gal", "gal.", "gallon", "gallons"] => :gallon,
        ["oz", "oz.", "ounce", "ounces"] => :ounce,
        ["pt", "pt.", "pint", "pints"] => :pint,
        ["lb", "lb.", "pound", "pounds"] => :pound,
        ["qt", "qt.", "qts", "qts.", "quart", "quarts"] => :quart,
        ["tbsp.", "tbsp", "T", "T.", "tablespoon", "tablespoons", "tbs.", "tbs"] => :tablespoon,
        ["tsp.", "tsp", "t", "t.", "teaspoon", "teaspoons"] => :teaspoon,
        ["g", "g.", "gr", "gr.", "gram", "grams"] => :gram,
        ["kg", "kg.", "kilogram", "kilograms"] => :kilogram,
        ["l", "l.", "liter", "liters"] => :liter,
        ["mg", "mg.", "milligram", "milligrams"] => :milligram,
        ["ml", "ml.", "milliliter", "milliliters"] => :milliliter,
        ["pinch", "pinches"] => :pinch,
        ["dash", "dashes"] => :dash,
        ["touch", "touches"] => :touch,
        ["handful", "handfuls"] => :handful
      }
    end

  end
end
