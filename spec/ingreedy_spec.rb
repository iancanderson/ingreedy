# encoding: utf-8
require "spec_helper"

describe Ingreedy, ".parse" do
  it "parses a simple example correctly" do
    result = Ingreedy.parse("1 lb potatoes")

    expect(result.amount).to eq(1)
    expect(result.unit).to eq(:pound)
    expect(result.ingredient).to eq("potatoes")
  end
end

describe Ingreedy, "amount parsing" do
  {
    "1 cup flour" => 1,
    "one cup flour" => 1,
    "1 1/2 cups flour" => "3/2",
    "¼ cups flour" => "1/4",
    "1 ½ cups flour" => "3/2",
    "1½ cups flour" => "3/2",
    "1.0 cup flour" => 1,
    "1.5 cups flour" => "3/2",
    "1,5 cups flour" => "3/2",
    "1 2/3 cups flour" => "5/3",
    "1 (28 ounce) can crushed tomatoes" => 1,
    "2 (28 ounce) can crushed tomatoes" => 2,
    "3 28 ounce can crushed tomatoes" => 3,
    "one 28 ounce can crushed tomatoes" => 1,
    "two five-ounce can crushed tomatoes" => 2,
    "two 28 ounce cans crushed tomatoes" => 2,
    "three 28 ounce cans crushed tomatoes" => 3,
    "1/2 cups flour" => "1/2",
    ".25 cups flour" => "1/4",
    "12oz tequila" => 12,
    "1 banana" => 1,
  }.each do |query, expected|
    it "parses the correct amount as a rational" do
      expect(Ingreedy.parse(query)).to parse_the_amount(expected.to_r)
    end
  end
end

describe Ingreedy, "amount parsing preserving original value" do
  around do |example|
    Ingreedy.preserve_amounts = true
    example.run
    Ingreedy.preserve_amounts = false
  end

  {
    "1 cup flour" => "1",
    "2 cups flour" => "2",
    "1 1/2 cups flour" => "1 1/2",
    "¼ cups flour" => "1/4",
    "1 ½ cups flour" => "1 1/2",
    "1½ cups flour" => "1 1/2",
    "1.0 cup flour" => "1.0",
    "1.5 cups flour" => "1.5",
    "1,5 cups flour" => "1,5",
    "1/2 cups flour" => "1/2",
    ".25 cups flour" => ".25",
  }.each do |query, expected|
    it "parses the correct amount" do
      expect(Ingreedy.parse(query).amount).to eq(expected)
    end
  end
end

describe Ingreedy, "english units" do
  context "abbreviated" do
    {
      "1 c flour" => :cup,
      "1 c. flour" => :cup,
      "1 fl oz flour" => :fluid_ounce,
      "1 fl. oz. flour" => :fluid_ounce,
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
      "1 tSP sugar" => :teaspoon,
    }.each do |query, expected|
      it "parses the #{expected} unit correctly" do
        expect(Ingreedy.parse(query)).to parse_the_unit(expected)
      end
    end
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
      "2 teaspoons flour" => :teaspoon,
    }.each do |query, expected|
      it "parses the units correctly" do
        expect(Ingreedy.parse(query)).to parse_the_unit(expected)
      end
    end
  end
end

describe Ingreedy, "metric units" do
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
      "1 ml. water" => :milliliter,
    }.each do |query, expected|
      it "parses the units correctly" do
        expect(Ingreedy.parse(query)).to parse_the_unit(expected)
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
      "2 milliliters water" => :milliliter,
    }.each do |query, expected|
      it "parses the units correctly" do
        expect(Ingreedy.parse(query)).to parse_the_unit(expected)
      end
    end
  end
end

describe Ingreedy, "nonstandard units" do
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
    "1 can of tomatoes" => :can,
  }.each do |query, expected|
    it "parses the units correctly" do
      expect(Ingreedy.parse(query)).to parse_the_unit(expected)
    end
  end
end

describe Ingreedy, "without units" do
  it "parses correctly" do
    result = Ingreedy.parse "3 eggs, lightly beaten"

    expect(result.amount).to eq(3)
    expect(result.unit).to be_nil
    expect(result.ingredient).to eq("eggs, lightly beaten")
  end
end

describe Ingreedy, "container as part of quantity" do
  it "parses correctly" do
    result = Ingreedy.parse "160g (2 cans) of tomatoes"

    expect(result.amount).to eq(160)
    expect(result.unit).to eq(:gram)
    expect(result.container_amount).to eq(2)
    expect(result.container_unit).to eq(:can)
    expect(result.ingredient).to eq("tomatoes")
  end

  context "on language without preposition" do
    before(:all) do
      Ingreedy.dictionaries[:id] = {
        units: {
          can: ["kaleng"],
          gram: ["g"],
          to_taste: ["secukupnya"],
        },
      }
      Ingreedy.locale = :id
    end

    after(:all) do
      Ingreedy.locale = nil
    end

    it "parses correctly" do
      result = Ingreedy.parse "160g (2 kaleng) tomat"

      expect(result.amount).to eq(160)
      expect(result.unit).to eq(:gram)
      expect(result.container_amount).to eq(2)
      expect(result.container_unit).to eq(:can)
      expect(result.ingredient).to eq("tomat")
    end
  end
end

describe Ingreedy, "with 'a' as quantity and preposition 'of'" do
  it "parses correctly" do
    result = Ingreedy.parse "a dash of ginger"

    expect(result.amount).to eq(1)
    expect(result.unit).to eq(:dash)
    expect(result.ingredient).to eq("ginger")
  end
end

describe Ingreedy, "with 'reverse format'" do
  it "works with words containing a 'word digit'" do
    result = Ingreedy.parse "salt 200g"

    expect(result.amount).to eq(200)
    expect(result.unit).to eq(:gram)
    expect(result.ingredient).to eq("salt")
  end

  it "works with words ending on a 'word digit'" do
    result = Ingreedy.parse "quinoa 200g"

    expect(result.amount).to eq(200)
    expect(result.unit).to eq(:gram)
    expect(result.ingredient).to eq("quinoa")
  end

  it "works with approximate quantities" do
    result = Ingreedy.parse "salt to taste"

    expect(result.ingredient).to eq("salt")
    expect(result.amount).to be_nil
    expect(result.unit).to eq(:to_taste)
  end
end

describe Ingreedy, "Given a range" do
  it "works with simple ranges" do
    result = Ingreedy.parse "1-2 tbsp salt"

    expect(result.amount).to eq([1, 2])
    expect(result.unit).to eq(:tablespoon)
    expect(result.ingredient).to eq("salt")
  end

  it "works with spaces" do
    result = Ingreedy.parse "1 - 2 tbsp salt"

    expect(result.amount).to eq([1, 2])
    expect(result.unit).to eq(:tablespoon)
    expect(result.ingredient).to eq("salt")
  end

  it "works with tilde" do
    result = Ingreedy.parse "1~2 tbsp salt"

    expect(result.amount).to eq([1, 2])
    expect(result.unit).to eq(:tablespoon)
    expect(result.ingredient).to eq("salt")
  end
end

describe Ingreedy, "parsing in language with no prepositions" do
  before(:all) do
    Ingreedy.dictionaries[:id] = {
      units: {
        gram: ["g"],
        to_taste: ["secukupnya"],
      },
    }
    Ingreedy.locale = :id
  end

  after(:all) do
    Ingreedy.locale = nil
  end

  it "parses correctly" do
    result = Ingreedy.parse "garam secukupnya"

    expect(result.amount).to be_nil
    expect(result.unit).to eq(:to_taste)
    expect(result.ingredient).to eq("garam")
  end
end

describe Ingreedy, "custom dictionaries" do
  context "using Ingreedy.locale=" do
    before(:all) do
      Ingreedy.dictionaries[:fr] = {
        numbers: { "une" => 1 },
        prepositions: ["de"],
        units: { dash: ["pincee"] },
      }
      Ingreedy.locale = :fr
    end

    after(:all) do
      Ingreedy.locale = nil
    end

    it "parses correctly" do
      result = Ingreedy.parse "une pincee de sucre"

      expect(result.amount).to eq(1)
      expect(result.unit).to eq(:dash)
      expect(result.ingredient).to eq("sucre")
    end
  end

  context "using I18n.locale" do
    before(:each) do
      Ingreedy.dictionaries[:de] = { units: { dash: ["prise"] } }
      stub_const "I18n", double("I18n", locale: :de)
    end

    it "parses correctly" do
      result = Ingreedy.parse "1 Prise Zucker"

      expect(result.amount).to eq(1)
      expect(result.unit).to eq(:dash)
      expect(result.ingredient).to eq("Zucker")
    end
  end

  context "unknown locale" do
    before(:all) do
      Ingreedy.locale = :da
    end

    after(:all) do
      Ingreedy.locale = nil
    end

    it "raises an informative exception" do
      expect do
        Ingreedy.parse "1 tsk salt"
      end.to raise_exception("No dictionary found for :da locale")
    end
  end

  context "Dictionary with no units" do
    it "raises an informative exception" do
      expect do
        Ingreedy.dictionaries[:da] = {}
      end.to raise_exception("No units found in dictionary")
    end
  end
end

describe Ingreedy, "ingredient formatting" do
  it "strips preceding or trailing whitespace" do
    expect(Ingreedy.parse("1 cup flour ").ingredient).to eq("flour")
  end
end

describe Ingreedy, "error handling" do
  it "wraps Parslet exceptions in a custom exception" do
    expect do
      Ingreedy.parse("nonsense")
    end.to raise_error Ingreedy::ParseFailed
  end
end
