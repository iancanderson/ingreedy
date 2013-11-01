class IngreedyParser

  attr_reader :amount, :unit, :ingredient, :query

  def initialize(query)
    @query = query
  end

  def parse
    ingreedy_regex = %r{
      (?<amount> .?\d+(\.\d+)? ) {0}
      (?<fraction> \d\/\d ) {0}

      (?<container_amount> \d+(\.\d+)?) {0}
      (?<container_unit> .+) {0}
      (?<container_size> \(\g<container_amount>\s\g<container_unit>\)) {0}
      (?<unit_and_ingredient> .+ ) {0}

      (\g<fraction>\s)?(\g<amount>\s?)?(\g<fraction>\s)?(\g<container_size>\s)?\g<unit_and_ingredient>
    }x
    results = ingreedy_regex.match(@query)

    @ingredient_string = results[:unit_and_ingredient]
    @container_amount = results[:container_amount]
    @container_unit = results[:container_unit]

    parse_amount results[:amount], results[:fraction]
    parse_unit_and_ingredient
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
    @amount *= @container_amount.to_f if @container_amount
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
    set_unit_variations :ounce, ["oz", "oz.", "ounce", "ounces"]
    set_unit_variations :pint, ["pt", "pt.", "pint", "pints"]
    set_unit_variations :pound, ["lb", "lb.", "pound", "pounds"]
    set_unit_variations :quart, ["qt", "qt.", "qts", "qts.", "quart", "quarts"]
    set_unit_variations :tablespoon, ["tbsp.", "tbsp", "T", "T.", "tablespoon", "tablespoons", "tbs.", "tbs"]
    set_unit_variations :teaspoon, ["tsp.", "tsp", "t", "t.", "teaspoon", "teaspoons"]
    # metric units
    set_unit_variations :gram, ["g", "g.", "gr", "gr.", "gram", "grams"]
    set_unit_variations :kilogram, ["kg", "kg.", "kilogram", "kilograms"]
    set_unit_variations :liter, ["l", "l.", "liter", "liters"]
    set_unit_variations :milligram, ["mg", "mg.", "milligram", "milligrams"]
    set_unit_variations :milliliter, ["ml", "ml.", "milliliter", "milliliters"]
    # nonstandard units
    set_unit_variations :pinch, ["pinch", "pinches"]
    set_unit_variations :dash, ["dash", "dashes"]
    set_unit_variations :touch, ["touch", "touches"]
    set_unit_variations :handful, ["handful", "handfuls"]
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

    # if no unit yet, try it again downcased
    if @unit.nil?
      @ingredient_string.downcase!
      @unit_map.each do |abbrev, unit|
        if @ingredient_string.start_with?(abbrev + " ")
          # if a unit is found, remove it from the ingredient string
          @ingredient_string.sub! abbrev, ""
          @unit = unit
        end
      end
    end

    # if we still don't have a unit, check to see if we have a container unit
    if @unit.nil? and @container_unit
      @unit_map.each do |abbrev, unit|
        @unit = unit if abbrev == @container_unit
      end
    end
  end
  def parse_unit_and_ingredient
    parse_unit
    # clean up ingredient string
    @ingredient = @ingredient_string.lstrip.rstrip
  end
end
