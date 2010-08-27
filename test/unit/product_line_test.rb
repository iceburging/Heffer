require 'test_helper'

class ProductLineTest < ActiveSupport::TestCase
  should_belong_to :manufacturer
  should_have_many :options, :photos
  should_have_and_belong_to_many :flags
  should_belong_to :category

  context "find_available" do
    setup do
      p1 = ProductLine.create()
      p1.options << Factory.create(:option, {:available => true})
      p2 = ProductLine.create()
      p2.options << Factory.create(:option, {:available => false})
      @available_product_lines = ProductLine.find_all_available
    end
    should "return only products with available options" do
    end
  end
end

