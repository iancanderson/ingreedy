require File.expand_path(File.dirname(__FILE__) + "/../lib/heavy")
require 'yaml'

describe "allrecipes.com top 20 recipes" do
  before(:all) do

  end
  it "should parse em up" do

  end
end

#
#def test_ingredient(expected_values, heavy_output)
#  it "should parse the expected values" do
#    heavy_output.amount.should == expected_values[1]
#    heavy_output.unit.should == expected_values[2]
#    heavy_output.ingredient.should == expected_values[3]
#  end
#end
#
#describe "allrecipes.com top 20 recipes" do
#  context "banana crumb muffins" do
#    context "english units" do
#      [["1 1/2 cups all-purpose flour", 1.5, :cup, "all-purpose flour"],
#      ["1 teaspoon baking soda", 1, :teaspoon, "baking soda"],
#      ["1 teaspoon baking powder", 1, :teaspoon, "baking powder"],
#      ["1/2 teaspoon salt", 0.5, :teaspoon, "salt"],
#      ["3 bananas, mashed", 3, nil, "bananas, mashed"],
#      ["3/4 cup white sugar", 0.75, :cup, "white sugar"],
#      ["1 egg, lightly beaten", 1, nil, "egg, lightly beaten"],
#      ["1/3 cup butter, melted", 1/3.0, :cup, "butter, melted"],
#      ["1/3 cup packed brown sugar", 1/3.0, :cup, "packed brown sugar"],
#      ["2 tablespoons all-purpose flour", 2, :tablespoon, "all-purpose flour"],
#      ["1/8 teaspoon ground cinnamon", 1/8.0, :teaspoon, "ground cinnamon"],
#      ["1 tablespoon butter", 1, :tablespoon, "butter"]].each do |expected_values|
#        test_ingredient(expected_values, Heavy.parse(expected_values[0]))
#      end
#    end
#    context "metric units" do
#      [["190 g all-purpose flour", 190, :gram, "all-purpose flour"],
#      ["5 g baking soda", 5, :gram, "baking soda"],
#      ["5 g baking powder", 5, :gram, "baking powder"],
#      ["3 g salt", 3, :gram, "salt"],
#      ["3 bananas, mashed", 3, nil, "bananas, mashed"],
#      ["150 g white sugar", 150, :gram, "white sugar"],
#      ["1 egg, lightly beaten", 1, nil, "egg, lightly beaten"],
#      ["75 g butter, melted", 75, :gram, "butter, melted"],
#      ["75 g packed brown sugar", 75, :gram, "packed brown sugar"],
#      ["15 g all-purpose flour", 15, :gram, "all-purpose flour"],
#      ["0.3 g ground cinnamon", 0.3, :gram, "ground cinnamon"],
#      ["15 g butter", 15, :gram, "butter"]].each do |expected_values|
#        test_ingredient(expected_values, Heavy.parse(expected_values[0]))
#      end
#    end
#  end
#  context "world's best lasagna" do
#    context "english units" do
#
#    end
#  end
#end