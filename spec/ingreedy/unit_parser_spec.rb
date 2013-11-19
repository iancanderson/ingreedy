require 'spec_helper'

describe Ingreedy::UnitParser do

  context 'english units' do
    it { should parse 'fl oz' }
    it { should parse 'fl. oz.' }
    it { should parse 'fluid ounce' }
    it { should parse 'fluid ounces' }

  end

  context 'metric units' do
    it { should parse 'g' }
    it { should parse 'g.' }
    it { should parse 'gram' }
    it { should parse 'grams' }
  end

  context 'mixed case' do

    it { should parse 'FLUID OUNCES' }
    it { should parse 'Tbs' }
    it { should parse 'TSP' }
    it { should parse 'tSP' }

  end

end
