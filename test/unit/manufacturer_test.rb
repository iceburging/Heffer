require 'test_helper'

class ManufacturerTest < ActiveSupport::TestCase
  should_have_many :product_lines
end

