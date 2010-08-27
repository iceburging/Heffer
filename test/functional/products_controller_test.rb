require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  context "GET to :list" do
    setup do
      get :list
    end
    should_assign_to :products
    should_respond_with :success
    should_render_template :list
    should_not_set_the_flash
  end
end

