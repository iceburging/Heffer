require 'test_helper'

class OptionTest < ActiveSupport::TestCase
  should_belong_to :product_line

  context "option with size 32C and colour Black" do
    setup do
      @option = Factory.build(:option,:colour => 'Black', :size => '32C')
    end
    should "return 32C Black as its name" do
      assert_equal '32C Black', @option.name
    end
  end

  context "option with remove set to 1" do
    setup do
      @option = Factory.build(:option,:remove => '1')
    end
    should "return true for remove" do
      assert_equal true, @option.remove?
    end
  end

  context "option with remove set to 0" do
    setup do
      @option = Factory.build(:option,:remove => '0')
    end
    should "return false for remove" do
      assert_equal false, @option.remove?
    end
  end
end

