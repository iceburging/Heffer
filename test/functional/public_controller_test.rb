require 'test_helper'

class PublicControllerTest < ActionController::TestCase
  context "GET to :home" do
    setup do
      get :home
    end
    should_respond_with :success
    should_render_template :home
    should_not_set_the_flash
    should_assign_to :cart
  end
end

