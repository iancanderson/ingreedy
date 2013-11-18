require 'spec_helper'

describe Ingreedy::AmountParser do

  context 'simple fractions' do

    it 'should parse' do
      subject.should parse('1/2')
    end

    it 'should capture a fraction' do
      result = subject.parse('1/2')

      result[:float_amount].should    == nil
      result[:fraction_amount].should == '1/2'
      result[:integer_amount].should  == nil
    end

  end

  context 'compound fractions' do

    it 'should parse' do
      subject.should parse('1 1/2')
    end

    it 'should capture an integer and a fraction' do
      result = subject.parse('1 1/2')

      result[:float_amount].should    == nil
      result[:fraction_amount].should == '1/2'
      result[:integer_amount].should  == '1'
    end

  end

  context 'decimals' do
    
    it 'should parse a short decimal' do
      subject.should parse('1.0')
    end

    it 'should parse a long decimal' do
      subject.should parse('3.1415926')
    end

    it 'should capture a float' do
      result = subject.parse('3.14')

      result[:float_amount].should    == '3.14'
      result[:fraction_amount].should == nil
      result[:integer_amount].should  == nil
    end

  end

  context 'integers' do

    it 'should parse a small integer' do
      subject.should parse('1')
    end

    it 'should parse a large integer' do
      subject.should parse('823842834')
    end

    it 'should capture an integer' do
      result = subject.parse('123')

      result[:float_amount].should    == nil
      result[:fraction_amount].should == nil
      result[:integer_amount].should  == '123'
    end

  end

  context 'junk' do

    it 'should not parse a non-number' do
      subject.should_not parse('asdf')
    end

  end

end
