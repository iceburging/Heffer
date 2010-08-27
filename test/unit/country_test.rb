require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  should_have_and_belong_to_many :shipping_methods
end

