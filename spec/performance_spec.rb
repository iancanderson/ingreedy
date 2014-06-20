require 'spec_helper'
require 'benchmark'

describe Ingreedy do

  #context "for simple queries" do

    #it "should parse a 10-ingredient recipe in less than 0.3 seconds" do
      #Benchmark.realtime {
        #10.times { Ingreedy.parse('1 lb potatoes') }
      #}.should < 0.3
    #end

  #end

  #it 'should parse units fast' do
    #Benchmark.realtime {
      #Ingreedy::UnitParser.new.parse('tbsp')
    #}.should < 0.01
  #end

  #it 'should parse amounts fast' do
    #Benchmark.realtime {
      #Ingreedy::AmountParser.new.parse('1 1/2')
    #}.should < 0.01
  #end

  #it 'should parse units faster with regex' do
    #Benchmark.realtime {
      #variations = Ingreedy::UnitVariationMapper.all_variations
      #case_sensitive = Regexp.union(variations)
      #case_insensitive = Regexp.union(variations.map{ |v| Regexp.new(v, Regexp::IGNORECASE) })
      #both = Regexp.union(case_sensitive, case_insensitive)
      #both.match('tbsp')
    #}.should < 0.001
  #end

end
