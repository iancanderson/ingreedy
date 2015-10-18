# encoding: utf-8
require "spec_helper"

describe Ingreedy::Rationalizer do
  subject { described_class }

  context "with an integer and a fraction" do
    it "gives back an improper rational" do
      rational = subject.rationalize(integer: "1", fraction: "1/2")
      expect(rational).to eq("3/2".to_r)
    end
  end

  context "with a fraction" do
    it "gives back a rational" do
      expect(subject.rationalize(fraction: "1/2")).to eq("1/2".to_r)
    end
  end

  context "with a vulgar fraction" do
    it "gives back a rational" do
      expect(subject.rationalize(fraction: "¼")).to eq("1/4".to_r)
    end
  end

  context "with an integer" do
    it "gives back a rational" do
      expect(subject.rationalize(integer: "2")).to eq("2".to_r)
    end
  end

  context "with a float" do
    it "gives back a rational" do
      expect(subject.rationalize(float: "0.3")).to eq("3/10".to_r)
    end
  end

  context "with a european float" do
    it "gives back a rational" do
      expect(subject.rationalize(float: "0,4")).to eq("4/10".to_r)
    end
  end

  context "with an english digit" do
    it "gives back a rational" do
      expect(subject.rationalize(word: "one")).to eq("1".to_r)
    end
  end

  context "with the word a or an" do
    it "gives back a rational" do
      expect(subject.rationalize(word: "a")).to eq("1".to_r)
      expect(subject.rationalize(word: "AN")).to eq("1".to_r)
    end
  end
end
