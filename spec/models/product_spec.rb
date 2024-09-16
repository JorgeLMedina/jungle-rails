require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # Create a valid category to be used in the tests
    before(:each) do
      @category = Category.create(name: 'Example Category')
    end

    # Example to ensure that a product with all required fields saves successfully
    it 'is valid with valid attributes' do
      product = Product.new(
        name: 'Example Product',
        price_cents: 1000,
        quantity: 10,
        category: @category
      )
      expect(product).to be_valid
    end

    # Validation tests
    it 'is not valid without a name' do
      product = Product.new(
        name: nil,
        price_cents: 1000,
        quantity: 10,
        category: @category
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without a price' do
      product = Product.new(
        name: 'Example Product',
        price_cents: nil,
        quantity: 10,
        category: @category
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'is not valid without a quantity' do
      product = Product.new(
        name: 'Example Product',
        price_cents: 1000,
        quantity: nil,
        category: @category
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is not valid without a category' do
      product = Product.new(
        name: 'Example Product',
        price_cents: 1000,
        quantity: 10,
        category: nil
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end

