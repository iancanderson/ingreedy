class UnitParser

  def initialize(query)
    @query = query
  end
  def parse
    heavy_regex = %r{
      (?<amount> \d+(\.\d+)? ) {0}
      (?<fraction> \d\/\d ) {0}
      (?<unit_and_ingredient> .+ ) {0}

      (\g<amount>\s)?(\g<fraction>\s)?\g<unit_and_ingredient>
    }x
    results = heavy_regex.match(@query)

    @ingredient_string = results[:unit_and_ingredient]

    parse_amount results[:amount], results[:fraction]
    parse_unit_and_ingredient
    # if no valid unit was given, prepend it to the ingredient
#    @ingredient = @unit ? results[:ingredient] : "#{results[:unit]} #{results[:ingredient]}"
  end
  def amount
    @amount
  end
  def unit
    @unit
  end
  def ingredient
    @ingredient
  end

  private
  def parse_amount(amount_string, fraction_string)
    fraction = 0
    if fraction_string
      numbers = fraction_string.split("\/")
      numerator = numbers[0].to_f
      denominator = numbers[1].to_f
      fraction = numerator / denominator
    end
    @amount = amount_string.to_f + fraction
  end
  def set_unit_variations(unit, variations)
    variations.each do |abbrev|
      @unit_map[abbrev] = unit
    end
  end
  def create_unit_map
    @unit_map = {}
    # english units
    set_unit_variations :cup, ["c.", "c", "cup", "cups"]
    set_unit_variations :fluid_ounce, ["fl. oz.", "fl oz", "fluid ounce", "fluid ounces"]
    set_unit_variations :gallon, ["gal", "gal.", "gallon", "gallons"]
    set_unit_variations :pint, ["pt", "pt.", "pint", "pints"]
    set_unit_variations :quart, ["qt", "qt.", "qts", "qts.", "quart", "quarts"]
    set_unit_variations :tablespoon, ["tbsp.", "tbsp", "T", "T.", "tablespoon", "tablespoons"]
    set_unit_variations :teaspoon, ["tsp.", "tsp", "t", "t.", "teaspoon", "teaspoons"]
    # metric units
    set_unit_variations :gram, ["g", "g.", "gr", "gr.", "gram", "grams"]
    set_unit_variations :kilogram, ["kg", "kg.", "kilogram", "kilograms"]
    set_unit_variations :liter, ["l", "l.", "liter", "liters"]
    set_unit_variations :milligram, ["mg", "mg.", "milligram", "milligrams"]
    set_unit_variations :milliliter, ["ml", "ml.", "milliliter", "milliliters"]
  end
  def parse_unit
    create_unit_map if @unit_map.nil?

    @unit_map.each do |abbrev, unit|
      if @ingredient_string.start_with?(abbrev + " ")
        # if a unit is found, remove it from the ingredient string
        @ingredient_string.sub! abbrev, ""
        @unit = unit
      end
    end
  end
  def parse_unit_and_ingredient
    parse_unit
    @ingredient = @ingredient_string
  end
end