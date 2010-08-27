require 'test_helper'

class MenuEntryTest < ActiveSupport::TestCase
  should "be valid" do
    assert MenuEntry.new.valid?
  end

  # menu entries should be stored in lowercase

end

