require "spec_helper"

describe Ingreedy::Parser, ".parse" do
  it "uses a custom dictionary if passed in" do
    result = Ingreedy::Parser.new(
      "une pincee de sucre",
      dictionary: Ingreedy::Dictionary.new(
        numbers: { "une" => 1 },
        prepositions: ["de"],
        units: { dash: ["pincee"] },
      )
    ).parse

    expect(result.amount).to eq(1)
    expect(result.unit).to eq(:dash)
    expect(result.ingredient).to eq("sucre")
  end
end
