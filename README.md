# Usage

```ruby
result = Ingreedy.parse('1 lb. potatoes')
print result.amount
  #=> 1.0
print result.unit
  #=> :pound
print result.ingredient
  #=> "potatoes"
```

### I18n and custom dictionaries

```ruby
Ingreedy.dictionaries[:fr] = { 
  units: { dash: ['pincée'] }, 
  numbers: { 'une' => 1 }, 
  prepositions: ['de'] 
}

Ingreedy.locale = :fr # Also automatically follows I18n.locale if available

result = Ingreedy.parse('une pincée de sucre')
print result.amount
  #=> 1.0
print result.unit
  #=> :dash
print result.ingredient
  #=> "sucre"
```

[Live demo](http://hangryingreedytest.herokuapp.com/)

# Pieces of Flair
- [![Gem Version](https://badge.fury.io/rb/ingreedy.png)](http://badge.fury.io/rb/ingreedy)
- [![Build Status](https://secure.travis-ci.org/iancanderson/ingreedy.png?branch=master)](http://travis-ci.org/iancanderson/ingreedy)
- [![Code Climate](https://codeclimate.com/github/iancanderson/ingreedy.png)](https://codeclimate.com/github/iancanderson/ingreedy)
- [![Coverage Status](https://coveralls.io/repos/iancanderson/ingreedy/badge.png)](https://coveralls.io/r/iancanderson/ingreedy)

# Development

Run the tests:
```
rspec spec
```
