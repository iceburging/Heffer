require 'test_helper'

class ShippingMethodTest < ActiveSupport::TestCase
  should_have_and_belong_to_many :countries
end

