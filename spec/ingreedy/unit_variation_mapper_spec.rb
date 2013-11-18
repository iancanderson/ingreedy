require 'spec_helper'

describe Ingreedy::UnitVariationMapper do
  subject { described_class }

  describe ".unit_from_variation" do

    context 'uppercased variation' do
      it 'should give back the correct unit as a symbol' do
        subject.unit_from_variation('TSP').should == :teaspoon
      end
    end

  end

end
