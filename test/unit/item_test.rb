require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  context "a new item created with one product_line option added" do
    setup do
      @item = Item.new(Factory.build(:option),1)
    end
    should "have a quantity of one" do
      assert_equal 1, @item.quantity
    end
    should "have an option" do
      assert_instance_of Option, @item.option
    end
    context "then incremented by 2" do
      setup do
        @item.increment_quantity(2)
      end
      should "have a quantity of 3" do
        assert_equal 3, @item.quantity
      end
    end
    context "then set_quantity to 5" do
      setup do
        @item.set_quantity(5)
      end
      should "have a quantity of 5" do
        assert_equal 5, @item.quantity
      end
    end
  end
  context "a new item created with a Royce Comfy Bra 32C Black added" do
    setup do
      manufacturer = Factory.create(:manufacturer,{:name => 'Royce'})
      product_line = Factory.create(:product_line,{:name => 'Comfy Bra',:manufacturer => manufacturer})
      option = Factory.create(:option,{:size => '32C', :colour => 'Black',:product_line => product_line})
      @item = Item.new(option,1)
    end
    should "return the title 'Royce Comfy Bra 32C Black''" do
      assert_equal 'Royce Comfy Bra 32C Black', @item.title
    end
  end
  context "a new item created with a quantity of 2 and a product_line price of £12.00" do
    setup do
      manufacturer = Factory.create(:manufacturer,{:name => 'Royce'})
      product_line = Factory.create(:product_line,{:price => '12.00',:manufacturer => manufacturer})
      option = Factory.create(:option,{:product_line => product_line})
      @item = Item.new(option,2)
    end
    should "return a value of £24.00" do
      assert_equal 24.00, @item.value
    end
  end
end

