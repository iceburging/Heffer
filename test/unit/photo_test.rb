require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  should_belong_to :product_line
end

