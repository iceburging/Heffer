require 'test_helper'

class CartTest < ActiveSupport::TestCase
  context "a new cart" do
    setup do
      @cart = Cart.new
    end
    should "be a cart object" do
      assert_instance_of Cart, @cart
    end
    should "be empty" do
      assert true, @cart.is_empty?
    end
    context "with a single instance of an item added" do
      setup do
        @option = Factory.create(:option)
        @cart.add_item(@option,1)
      end
      should "return 1 item with a quantity of 1" do
        assert_equal 1, @cart.items.length
        assert_equal 1, @cart.items[0].quantity
      end
      should "return a count of 1" do
        assert_equal 1, @cart.count
      end
      context "then another instance the same item added" do
        setup do
          @cart.add_item(@option,1)
        end
        should "return 1 item with a quantity of 2" do
          assert_equal 1, @cart.items.length
          assert_equal 2, @cart.items[0].quantity
        end
        should "return a count of 2" do
          assert_equal 2, @cart.count
        end
      end
      context "that is emptied" do
        setup do
          @cart.empty
        end
        should "be empty" do
          assert true, @cart.is_empty?
        end
      end
      context "that has the item removed" do
        setup do
          @cart.remove_item(@option)
        end
        should "be empty" do
          assert true, @cart.is_empty?
        end
      end
    end
    context "with two instances of one item added" do
      setup do
        @option = Factory.create(:option)
        @cart.add_item(@option,2)
      end
      should "return 1 item with a quantity of 2" do
        assert_equal 1, @cart.items.length
        assert_equal 2, @cart.items[0].quantity
      end
      context "updated to have one instance of one item added" do
        setup do
          @cart.update_item(@option,1)
        end
        should "return 1 item with a quantity of 1" do
          assert_equal 1, @cart.items.length
          assert_equal 1, @cart.items[0].quantity
        end
        should "return a count of 1" do
          assert_equal 1, @cart.count
        end
      end
    end
  end
end

