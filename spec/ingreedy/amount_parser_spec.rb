# encoding: utf-8
require "spec_helper"

describe Ingreedy::AmountParser do
  context "given mixed case insensitive english words" do
    %w(one two three four five six seven eight nine ten eleven twelve).each do |word|
      word += " "
      it %(parses a lowercase "#{word}" followed by space) do
        expect(subject).to parse(word)
      end

      it %(parses a uppercase "#{word}") do
        expect(subject).to parse(word.upcase)
      end
    end
  end

  context "simple fractions" do
    it "parses" do
      expect(subject).to parse("1/2")
    end

    it "parses vulgar fractions" do
      expect(subject).to parse("½")
    end

    it "captures a fraction" do
      result = subject.parse("1/2")

      expect(result[:float_amount]).to eq(nil)
      expect(result[:fraction_amount]).to eq("1/2")
      expect(result[:integer_amount]).to eq(nil)
    end
  end

  context "compound fractions" do
    it "parses" do
      expect(subject).to parse("1 1/2")
    end

    it "captures an integer and a fraction" do
      result = subject.parse("1 1/2")

      expect(result[:float_amount]).to eq(nil)
      expect(result[:fraction_amount]).to eq("1/2")
      expect(result[:integer_amount]).to eq("1")
    end
  end

  context "decimals" do
    it "parses a short decimal" do
      expect(subject).to parse("1.0")
    end

    it "parses a long decimal" do
      expect(subject).to parse("3.1415926")
    end

    it "captures a float" do
      result = subject.parse("3.14")

      expect(result[:float_amount]).to eq("3.14")
      expect(result[:fraction_amount]).to eq(nil)
      expect(result[:integer_amount]).to eq(nil)
    end

    it "captures a european style float" do
      result = subject.parse("3,14")

      expect(result[:float_amount]).to eq("3,14")
      expect(result[:fraction_amount]).to eq(nil)
      expect(result[:integer_amount]).to eq(nil)
    end
  end

  context "integers" do
    it "parses a small integer" do
      expect(subject).to parse("1")
    end

    it "parses a large integer" do
      expect(subject).to parse("823842834")
    end

    it "captures an integer" do
      result = subject.parse("123")

      expect(result[:float_amount]).to eq(nil)
      expect(result[:fraction_amount]).to eq(nil)
      expect(result[:integer_amount]).to eq("123")
    end
  end

  context "junk" do
    it "doesn't parse a non-number" do
      expect(subject).not_to parse("asdf")
    end
  end
end
