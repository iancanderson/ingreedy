if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

require 'ingreedy'
require 'parslet/rig/rspec'
require 'pry'
require 'rspec/its'

RSpec::Matchers.define :parse_the_unit do |unit|
  match do |ingreedy_output|
    ingreedy_output.unit == unit
  end
  failure_message do |ingreedy_output|
    "expected to parse the unit #{unit} from the query '#{ingreedy_output.original_query}' " +
    "got '#{ingreedy_output.unit}' instead"
  end
end

RSpec::Matchers.define :parse_the_amount do |amount|
  match do |ingreedy_output|
    ingreedy_output.amount == amount
  end
  failure_message do |ingreedy_output|
    "expected to parse the amount #{amount} from the query '#{ingreedy_output.original_query}.' " +
    "got '#{ingreedy_output.amount}' instead"
  end
end

