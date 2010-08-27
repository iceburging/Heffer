require 'test_helper'

class PageTest < ActiveSupport::TestCase
  should_belong_to :menu_entry

  context "a page after_validation" do
    setup do
      @page = Factory.create(:page, :title => 'A test page')
    end
    should "generate and store a permalink" do
      assert_equal @page.permalink, "a_test_page"
    end
  end

  # page title should be unique

end

