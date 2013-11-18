require 'spec_helper'

describe Ingreedy::UnitParser do

  context 'case_sensitive_unit rule' do
    subject { described_class.new.case_sensitive_unit }

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

  end

  context 'case_insensitive_unit rule' do
    subject { described_class.new.case_insensitive_unit }

    it { should parse 'FLUID OUNCES' }
    it { should parse 'Tbs' }
    it { should parse 'TSP' }

  end

end
