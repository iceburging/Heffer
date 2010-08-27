require 'test_helper'

class CheckoutControllerTest < ActionController::TestCase
  context "GET to :show_cart with empty cart" do
    setup do
      get :show_cart
    end
    should_assign_to :order
    should_respond_with :success
    should_render_template :empty_cart
    should_not_set_the_flash
  end

  context "GET to :show_cart with items in cart and no :delivery_country" do
    setup do
      Cart.any_instance.stubs(:is_empty?).returns(false)
      get :show_cart
    end
    should_assign_to :order
    should_redirect_to("edit country page") {'/checkout/edit_country'}
    should_not_set_the_flash
  end

  context "PUT to :update_order" do
    setup do
      order = Order.create(:shipping_method => Factory.create(:shipping_method)) # blank order
      put :update_order, {:order=>order.attributes}
    end
    should_assign_to :order
    should_redirect_to("show cart page") {'/checkout/show_cart'}
    should_not_set_the_flash # perhaps change this
  end

  context "GET to :invoice with completed order" do
    setup do
      option = Factory.create(:example_product).options[0]
      cart = Cart.new
      cart.add_item(option,2)
      @order = Factory.build(:completed_order)
      @order.cart = cart
      @order.save(false)
      @request.session[:order] = @order
      @request.session[:cart] = @order.cart
      get :invoice
    end
  end

end

