require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      product = Product.new(
        name: "Example Product",
        price: 10.99,
        quantity: 5,
        category: Category.new
      )
      expect(product).to be_valid
    end
  
    it "is not valid without a name" do
      product = Product.new(
        price: 10.99,
        quantity: 5,
        category: Category.new
      )
      expect(product).not_to be_valid
      expect(product.errors[:name]).to include("can't be blank")
    end
  
    it "is not valid without a price" do
      product = Product.new(
        name: "Example Product",
        quantity: 5,
        category: Category.new
      )
      expect(product).not_to be_valid
      expect(product.errors[:price]).to include("can't be blank")
    end
  
    it "is not valid without a quantity" do
      product = Product.new(
        name: "Example Product",
        price: 10.99,
        category: Category.new
      )
      expect(product).not_to be_valid
      expect(product.errors[:quantity]).to include("can't be blank")
    end
  
    it "is not valid without a category" do
      product = Product.new(
        name: "Example Product",
        price: 10.99,
        quantity: 5
      )
      expect(product).not_to be_valid
      expect(product.errors[:category]).to include("can't be blank")
    end
  end
end