require 'spec_helper'

describe Ingreedy::AmountParser do

  context 'given mixed case insensitive english words' do
    %w|one two three four five six seven eight nine ten eleven twelve|.each do |word|
      word += ' '
      it %Q|parses a lowercase "#{word}" followed by space| do
        expect(subject).to parse(word )
      end

      it %Q|parses a uppercase "#{word}"| do
        expect(subject).to parse(word.upcase)
      end
    end
  end

  context 'simple fractions' do

    it 'should parse' do
      expect(subject).to parse('1/2')
    end

    it 'should capture a fraction' do
      result = subject.parse('1/2')

      expect(result[:float_amount]).to    eq(nil)
      expect(result[:fraction_amount]).to eq('1/2')
      expect(result[:integer_amount]).to  eq(nil)
    end

  end

  context 'compound fractions' do

    it 'should parse' do
      expect(subject).to parse('1 1/2')
    end

    it 'should capture an integer and a fraction' do
      result = subject.parse('1 1/2')

      expect(result[:float_amount]).to    eq(nil)
      expect(result[:fraction_amount]).to eq('1/2')
      expect(result[:integer_amount]).to  eq('1')
    end

  end

  context 'decimals' do

    it 'should parse a short decimal' do
      expect(subject).to parse('1.0')
    end

    it 'should parse a long decimal' do
      expect(subject).to parse('3.1415926')
    end

    it 'should capture a float' do
      result = subject.parse('3.14')

      expect(result[:float_amount]).to    eq('3.14')
      expect(result[:fraction_amount]).to eq(nil)
      expect(result[:integer_amount]).to  eq(nil)
    end

  end

  context 'integers' do

    it 'should parse a small integer' do
      expect(subject).to parse('1')
    end

    it 'should parse a large integer' do
      expect(subject).to parse('823842834')
    end

    it 'should capture an integer' do
      result = subject.parse('123')

      expect(result[:float_amount]).to    eq(nil)
      expect(result[:fraction_amount]).to eq(nil)
      expect(result[:integer_amount]).to  eq('123')
    end

  end

  context 'junk' do

    it 'should not parse a non-number' do
      expect(subject).not_to parse('asdf')
    end

  end

end
