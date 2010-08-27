require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  should_have_many :product_lines
  should_have_many :flags
end

