require 'test_helper'

class FlagTest < ActiveSupport::TestCase
  should_have_and_belong_to_many :product_lines
end

