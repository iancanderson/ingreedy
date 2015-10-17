require 'spec_helper'

describe Ingreedy::UnitParser do

  context 'english units' do
    it { is_expected.to parse 'fl oz' }
    it { is_expected.to parse 'fl. oz.' }
    it { is_expected.to parse 'fluid ounce' }
    it { is_expected.to parse 'fluid ounces' }

  end

  context 'metric units' do
    it { is_expected.to parse 'g' }
    it { is_expected.to parse 'g.' }
    it { is_expected.to parse 'gram' }
    it { is_expected.to parse 'grams' }
  end

  context 'mixed case' do

    it { is_expected.to parse 'FLUID OUNCES' }
    it { is_expected.to parse 'Tbs' }
    it { is_expected.to parse 'TSP' }
    it { is_expected.to parse 'tSP' }

  end

end
