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
        ["cups", "cup", "c.", "c"] => :cup,
        ["fluid ounces", "fluid ounce", "fl. oz.", "fl oz"] => :fluid_ounce,
        ["gallons", "gallon", "gal.", "gal"] => :gallon,
        ["ounces", "ounce", "oz.", "oz"] => :ounce,
        ["pints", "pint", "pt.", "pt"] => :pint,
        ["pounds", "pound", "lbs.", "lbs", "lb.", "lb"] => :pound,
        ["quarts", "quart", "qts.", "qts", "qt.", "qt"] => :quart,
        ["tablespoons", "tablespoon", "tbsp.", "tbsp", "tbs.", "tbs", "T", "T."] => :tablespoon,
        ["teaspoons", "teaspoon", "tsp.", "tsp", "t", "t."] => :teaspoon,
        ["grams", "gram", "gr.", "gr", "g.", "g"] => :gram,
        ["kilograms", "kilogram", "kg.", "kg"] => :kilogram,
        ["liters", "liter", "l.", "l"] => :liter,
        ["milligrams", "milligram", "mg.", "mg"] => :milligram,
        ["milliliters", "milliliter", "ml.", "ml"] => :milliliter,
        ["pinches", "pinch"] => :pinch,
        ["dashes", "dash"] => :dash,
        ["touches", "touch"] => :touch,
        ["handfuls", "handful"] => :handful
      }
    end

  end
end
