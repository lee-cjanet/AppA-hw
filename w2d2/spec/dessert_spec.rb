require 'rspec'
require 'dessert'
require 'active_support/inflector'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  subject(:cake) {Dessert.new("cake", 2, "janet")}
  let(:chef) { double("chef") }

  describe "#initialize" do
    it "sets a type" do
      expect(cake.type).to eq ("cake")
    end

    it "sets a quantity" do
      expect(cake.quantity).to eq (30)
    end

    it "starts ingredients as an empty array" do
      expect(:ingredients).to eq ([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("chocolate", "4")}.to raise_error
    end
  end

  describe "#add_ingredient" do
    # subject("flour") { cake.add_ingredient("flour")}
    cake.add_ingredient("flour")
    it "adds an ingredient to the ingredients array" do
      expect(cake.ingredients).to include("flour")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredients = ["flour", "suguar", "baking soda", "love"]

      ingredients.each {|food| cake.add_ingredient(food)}

      expect(cake.ingredients.sort).to eq (ingredients.sort)
      cake.mix!
      expect(cake.ingredients).not_to eq (ingredients)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      cake.eat(10)
      expect(cake.quantity).to eq (20)
    end

    it "raises an error if the amount is greater than the quantity" do
      cake.eat(35)
      expect(cake.quantity).to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect(chef.titleize).to eq ("Janet")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(cake)
     cake.make_more
    end
  end
end
