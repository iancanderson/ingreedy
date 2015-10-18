require "spec_helper"

describe Ingreedy::UnitVariationMapper do
  subject { described_class }

  describe ".unit_from_variation" do
    context "uppercased variation" do
      it "gives back the correct unit as a symbol" do
        expect(subject.unit_from_variation("TSP")).to eq(:teaspoon)
      end
    end
  end
end
