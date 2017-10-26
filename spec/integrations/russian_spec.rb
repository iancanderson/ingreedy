RSpec.describe "Russian language" do
  before(:each) do
    Ingreedy.dictionaries[:ru] = { units: { piece: ["шт"] } }
    stub_const "I18n", double("I18n", locale: :ru)
  end

  it "parses correctly" do
    result = Ingreedy.parse "Для: 1 шт яйцо" # For: 1 piece egg

    expect(result.amount).to eq(1)
    expect(result.unit).to eq(:piece)
    expect(result.ingredient).to eq("яйцо")
  end
end
