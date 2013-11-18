require 'spec_helper'

describe Ingreedy do

  context "amount parsing" do

    {
      "1 cup flour" => 1,
      "1 1/2 cups flour" => '3/2',
      "1.0 cup flour" => 1,
      "1.5 cups flour" => '3/2',
      "1 2/3 cups flour" => '5/3',
      "1 (28 ounce) can crushed tomatoes" => 28,
      "2 (28 ounce) can crushed tomatoes" => 56,
      "1/2 cups flour" => '1/2',
      ".25 cups flour" => '1/4',
      "12oz tequila" => 12
    }.each do |query, expected|

      it "should parse the correct amount as a rational" do
        Ingreedy.parse(query).should parse_the_amount(expected.to_r)
      end

    end

  end

  context "unit parsing" do

    context "(english)" do

    end

    context "(metric)" do

    end

    context "(nonstandard)" do

    end
  end

  context "all together now" do
    subject { Ingreedy.parse('1 lb potatoes') }

    its(:amount) { should == 1 }
    its(:unit) { should == :pound }
    its(:ingredient) { should == 'potatoes' }

  end

end

describe "english units" do
  context "abbreviated" do
    {
      #"1 c flour" => :cup,
      #"1 c. flour" => :cup,
      #"1 fl oz flour" => :fluid_ounce,
      #"1 fl. oz. flour" => :fluid_ounce,
      #"1 (28 fl oz) can crushed tomatoes" => :fluid_ounce,
      #"2 gal flour" => :gallon,
      #"2 gal. flour" => :gallon,
      #"1 ounce flour" => :ounce,
      #"2 ounces flour" => :ounce,
      #"1 oz flour" => :ounce,
      #"1 oz. flour" => :ounce,
      #"2 pt flour" => :pint,
      #"2 pt. flour" => :pint,
      #"1 lb flour" => :pound,
      #"1 lb. flour" => :pound,
      #"1 pound flour" => :pound,
      #"2 pounds flour" => :pound,
      #"2 qt flour" => :quart,
      #"2 qt. flour" => :quart,
      #"2 qts flour" => :quart,
      #"2 qts. flour" => :quart,
      #"2 tbsp flour" => :tablespoon,
      #"2 tbsp. flour" => :tablespoon,
      "2 Tbs flour" => :tablespoon,
      #"2 Tbs. flour" => :tablespoon,
      #"2 T flour" => :tablespoon,
      #"2 T. flour" => :tablespoon,
      #"2 tsp flour" => :teaspoon,
      #"2 tsp. flour" => :teaspoon,
      #"2 t flour" => :teaspoon,
      #"2 t. flour" => :teaspoon,
      #"12oz tequila" => :ounce,
      #"2 TSP flour" => :teaspoon,
      #"1 LB flour" => :pound
    }.each do |query, expected|

      it "should parse the units correctly" do
        Ingreedy.parse(query).should parse_the_unit(expected)
      end

    end
  end

  context 'unit rule' do
    subject { Ingreedy::Parser.new('1 Tbs salt').unit }

    it { should parse 'Tbs' }
    it { should_not parse 'Tbbbbbs' }

  end

=begin
  context "long form" do
    before(:all) do
      @expected_units = {}
      @expected_units["1 cup flour"] = :cup
      @expected_units["2 cups flour"] = :cup
      @expected_units["1 fluid ounce flour"] = :fluid_ounce
      @expected_units["2 fluid ounces flour"] = :fluid_ounce
      @expected_units["2 gallon flour"] = :gallon
      @expected_units["2 gallons flour"] = :gallon
      @expected_units["2 pint flour"] = :pint
      @expected_units["2 pints flour"] = :pint
      @expected_units["1 quart flour"] = :quart
      @expected_units["2 quarts flour"] = :quart
      @expected_units["2 tablespoon flour"] = :tablespoon
      @expected_units["2 tablespoons flour"] = :tablespoon
      @expected_units["2 teaspoon flour"] = :teaspoon
      @expected_units["2 teaspoons flour"] = :teaspoon
    end
    it "should parse the units correctly" do
      @expected_units.each do |query, expected|
        Ingreedy.parse(query).should parse_the_unit(expected)
      end
    end
  end
=end
end

=begin
describe "metric units" do
  context "abbreviated" do
    before(:all) do
      @expected_units = {}
      @expected_units["1 g flour"] = :gram
      @expected_units["1 g. flour"] = :gram
      @expected_units["1 gr flour"] = :gram
      @expected_units["1 gr. flour"] = :gram
      @expected_units["1 kg flour"] = :kilogram
      @expected_units["1 kg. flour"] = :kilogram
      @expected_units["1 l water"] = :liter
      @expected_units["1 l. water"] = :liter
      @expected_units["1 mg water"] = :milligram
      @expected_units["1 mg. water"] = :milligram
      @expected_units["1 ml water"] = :milliliter
      @expected_units["1 ml. water"] = :milliliter
    end
    it "should parse the units correctly" do
      @expected_units.each do |query, expected|
        Ingreedy.parse(query).should parse_the_unit(expected)
      end
    end
  end
  context "long form" do
    before(:all) do
      @expected_units = {}
      @expected_units["1 gram flour"] = :gram
      @expected_units["2 grams flour"] = :gram
      @expected_units["1 kilogram flour"] = :kilogram
      @expected_units["2 kilograms flour"] = :kilogram
      @expected_units["1 liter water"] = :liter
      @expected_units["2 liters water"] = :liter
      @expected_units["1 milligram water"] = :milligram
      @expected_units["2 milligrams water"] = :milligram
      @expected_units["1 milliliter water"] = :milliliter
      @expected_units["2 milliliters water"] = :milliliter
    end
    it "should parse the units correctly" do
      @expected_units.each do |query, expected|
        Ingreedy.parse(query).should parse_the_unit(expected)
      end
    end
  end
end

describe "nonstandard units" do
  before(:all) do
    @expected_units = {}
    @expected_units["1 pinch pepper"] = :pinch
    @expected_units["2 pinches pepper"] = :pinch
    @expected_units["1 dash salt"] = :dash
    @expected_units["2 dashes salt"] = :dash
    @expected_units["1 touch hot sauce"] = :touch
    @expected_units["2 touches hot sauce"] = :touch
    @expected_units["1 handful rice"] = :handful
    @expected_units["2 handfuls rice"] = :handful
  end
  it "should parse the units correctly" do
    @expected_units.each do |query, expected|
      Ingreedy.parse(query).should parse_the_unit(expected)
    end
  end
end

describe "without units" do
  before(:all) { @ingreedy = Ingreedy.parse "3 eggs, lightly beaten" }

  it "should have an amount of 3" do
    @ingreedy.amount.should == 3
  end

  it "should have a nil unit" do
    @ingreedy.unit.should be_nil
  end

  it "should have the correct ingredient" do
    @ingreedy.ingredient.should == "eggs, lightly beaten"
  end
end

describe "ingredient formatting" do
  it "should not have any preceding or trailing whitespace" do
    Ingreedy.parse("1 cup flour ").ingredient.should == "flour"
  end
end
=end
