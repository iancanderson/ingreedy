require 'spec_helper'

describe Ingreedy do

  context "amount parsing" do

    {
      "1 cup flour" => 1,
      "one cup flour" => 1,
      "1 1/2 cups flour" => '3/2',
      "1.0 cup flour" => 1,
      "1.5 cups flour" => '3/2',
      "1 2/3 cups flour" => '5/3',
      "1 (28 ounce) can crushed tomatoes" => 28,
      "2 (28 ounce) can crushed tomatoes" => 56,
      "3 28 ounce can crushed tomatoes" => 84,
      "one 28 ounce can crushed tomatoes" => 28,
      "two five-ounce can crushed tomatoes" => 10,
      "two 28 ounce cans crushed tomatoes" => 56,
      "three 28 ounce cans crushed tomatoes" => 84,
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
      "1 c flour" => :cup,
      "1 c. flour" => :cup,
      "1 fl oz flour" => :fluid_ounce,
      "1 fl. oz. flour" => :fluid_ounce,
      "1 (28 fl oz) can crushed tomatoes" => :fluid_ounce,
      "2 gal flour" => :gallon,
      "2 gal. flour" => :gallon,
      "1 ounce flour" => :ounce,
      "2 ounces flour" => :ounce,
      "1 oz flour" => :ounce,
      "1 oz. flour" => :ounce,
      "2 pt flour" => :pint,
      "2 pt. flour" => :pint,
      "1 lb flour" => :pound,
      "1 lb. flour" => :pound,
      "1 pound flour" => :pound,
      "2 pounds flour" => :pound,
      "2 qt flour" => :quart,
      "2 qt. flour" => :quart,
      "2 qts flour" => :quart,
      "2 qts. flour" => :quart,
      "2 tbsp flour" => :tablespoon,
      "2 tbsp. flour" => :tablespoon,
      "2 Tbs flour" => :tablespoon,
      "2 Tbs. flour" => :tablespoon,
      "2 T flour" => :tablespoon,
      "2 T. flour" => :tablespoon,
      "2 tsp flour" => :teaspoon,
      "2 tsp. flour" => :teaspoon,
      "2 t flour" => :teaspoon,
      "2 t. flour" => :teaspoon,
      "12oz tequila" => :ounce,
      "2 TSP flour" => :teaspoon,
      "1 LB flour" => :pound,
      "1 tSP sugar" => :teaspoon
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

    it { should parse 'Tbs' }
    it { should parse 'tBS' }
    it { should parse 'tBs' }
    it { should parse 'TBs' }
    it { should parse 'TBS' }
    it { should parse 'tbs' }
  end

  context 'unit_and_preposition rule' do
    subject { Ingreedy::Parser.new('1 pinch of salt').unit_and_preposition }

    it { should parse 'pInch ' }
    it { should parse 'pinch of ' }
  end

  context "long form" do
    {
      "1 cup flour" => :cup,
      "2 cups flour" => :cup,
      "1 fluid ounce flour" => :fluid_ounce,
      "2 fluid ounces flour" => :fluid_ounce,
      "2 gallon flour" => :gallon,
      "2 gallons flour" => :gallon,
      "2 pint flour" => :pint,
      "2 pints flour" => :pint,
      "1 quart flour" => :quart,
      "2 quarts flour" => :quart,
      "2 tablespoon flour" => :tablespoon,
      "2 tablespoons flour" => :tablespoon,
      "2 teaspoon flour" => :teaspoon,
      "2 teaspoons flour" => :teaspoon
    }.each do |query, expected|
      it "should parse the units correctly" do
        Ingreedy.parse(query).should parse_the_unit(expected)
      end
    end
  end
end

describe "metric units" do
  context "abbreviated" do
    {
      "1 g flour" => :gram,
      "1 g. flour" => :gram,
      "1 gr flour" => :gram,
      "1 gr. flour" => :gram,
      "1 kg flour" => :kilogram,
      "1 kg. flour" => :kilogram,
      "1 l water" => :liter,
      "1 l. water" => :liter,
      "1 mg water" => :milligram,
      "1 mg. water" => :milligram,
      "1 ml water" => :milliliter,
      "1 ml. water" => :milliliter
    }.each do |query, expected|
      it "should parse the units correctly" do
        Ingreedy.parse(query).should parse_the_unit(expected)
      end
    end
  end

  context "long form" do
    {
      "1 gram flour" => :gram,
      "2 grams flour" => :gram,
      "1 kilogram flour" => :kilogram,
      "2 kilograms flour" => :kilogram,
      "1 liter water" => :liter,
      "2 liters water" => :liter,
      "1 milligram water" => :milligram,
      "2 milligrams water" => :milligram,
      "1 milliliter water" => :milliliter,
      "2 milliliters water" => :milliliter
    }.each do |query, expected|
      it "should parse the units correctly" do
        Ingreedy.parse(query).should parse_the_unit(expected)
      end
    end
  end
end

describe "nonstandard units" do
  {
    "1 pinch pepper" => :pinch,
    "2 pinches pepper" => :pinch,
    "1 dash salt" => :dash,
    "2 dashes salt" => :dash,
    "1 touch hot sauce" => :touch,
    "2 touches hot sauce" => :touch,
    "1 handful rice" => :handful,
    "2 handfuls rice" => :handful,
    "1 stick of butter" => :stick,
    "2 cloves of garlic" => :clove,
    "1 can of tomatoes" => :can
  }.each do |query, expected|
    it "should parse the units correctly" do
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

describe "with 'a' as quantity and preposition 'of'" do
  before(:all) { @ingreedy = Ingreedy.parse "a dash of ginger" }

  it "should have the correct amount" do
    @ingreedy.amount.should == 1
  end

  it "should have the correct unit" do
    @ingreedy.unit.should == :dash
  end

  it "should have the correct ingredient" do
    @ingreedy.ingredient.should == "ginger"
  end
end

describe "with 'reverse format'" do
  it "should work with words containing a 'word digit'" do
    @ingreedy = Ingreedy.parse "salt 200g"
    @ingreedy.amount.should == 200
    @ingreedy.unit.should == :gram
    @ingreedy.ingredient.should == "salt"
  end

  it "should work with words ending on a 'word digit'" do
    @ingreedy = Ingreedy.parse "quinoa 200g"
    @ingreedy.amount.should == 200
    @ingreedy.unit.should == :gram
    @ingreedy.ingredient.should == "quinoa"
  end

  it "should work with approximate quantities" do
    @ingreedy = Ingreedy.parse "salt to taste"
    @ingreedy.ingredient.should == "salt"
    @ingreedy.amount.should be_nil
    @ingreedy.unit.should == :to_taste
  end
end

describe "parsing in language with no prepositions" do
  before(:all) do
    Ingreedy.dictionaries[:id] = { units: { to_taste: ['secukupnya'], gram: ['g'] } }
    Ingreedy.locale = :id
    @ingreedy = Ingreedy.parse "garam secukupnya"
  end

  after(:all) do
    Ingreedy.locale = nil
  end

  it "should have a nil amount" do
    @ingreedy.amount.should be_nil
  end

  it "should have the correct  unit" do
    @ingreedy.unit.should == :to_taste
  end

  it "should have the correct ingredient" do
    @ingreedy.ingredient.should == "garam"
  end
end


describe "custom dictionaries" do
  context "using Ingreedy.locale=" do
    before(:all) do
      Ingreedy.dictionaries[:fr] = { units: { dash: ['pincee'] }, numbers: { 'une' => 1 }, prepositions: ['de'] }
      Ingreedy.locale = :fr
      @ingreedy = Ingreedy.parse "une pincee de sucre"
    end

    after(:all) do
      Ingreedy.locale = nil
    end

    it "should have the correct amount" do
      @ingreedy.amount.should == 1
    end

    it "should have the correct unit" do
      @ingreedy.unit.should == :dash
    end

    it "should have the correct ingredient" do
      @ingreedy.ingredient.should == "sucre"
    end
  end

  context "using I18n.locale" do
    before(:all) do
      Ingreedy.dictionaries[:de] = { units: { dash: ['prise'] } }
      RSpec::Mocks::setup(self)
      stub_const 'I18n', double('I18n', locale: :de)
      @ingreedy = Ingreedy.parse "1 Prise Zucker"
    end

    it "should have the correct amount" do
      @ingreedy.amount.should == 1
    end

    it "should have the correct unit" do
      @ingreedy.unit.should == :dash
    end

    it "should have the correct ingredient" do
      @ingreedy.ingredient.should == "Zucker"
    end
  end

  context "unknown locale" do
    before(:all) do
      Ingreedy.locale = :da
    end

    after(:all) do
      Ingreedy.locale = nil
    end

    it "should raise an informative exception" do
      lambda { Ingreedy.parse "1 tsk salt" }.should raise_exception('No dictionary found for :da locale')
    end
  end

  context "Dictionary with no units" do
    it "should raise an informative exception" do
      lambda { Ingreedy.dictionaries[:da] = {} }.should raise_exception('No units found in dictionary')
    end
  end
end

describe "ingredient formatting" do
  it "should not have any preceding or trailing whitespace" do
    Ingreedy.parse("1 cup flour ").ingredient.should == "flour"
  end
end
