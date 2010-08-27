require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  context "order with no items in its cart" do
    setup do
      @order = Order.new
    end
    should "return false on #has_items?" do
      assert_equal false, @order.has_items?
    end
  end
  context "order with one instance of an item in its cart" do
    setup do
      cart = Cart.new
      option = Factory.new(:option)
      cart.add_item(option,1)
      @order = Order.new({:cart => cart})
    end
    should "have one item in its cart" do
      assert_equal 1, @order.cart.items.length
    end
  end
  context "order with one £12.99 item in its cart" do
    setup do
      cart = Cart.new
      product_line = Factory.build(:product_line,:price => 12.99)
      option = Factory.build(:option,:product_line => product_line)
      cart.add_item(option,1)
      @order = Order.new({:cart => cart})
    end
    should "have a subtotal of £12.99" do
      assert_equal 12.99, @order.subtotal
    end
    context "and a discount of £5" do
      setup do
        @order.discount_value = 5
      end
      should "have a total of £12.99" do
        assert_equal 7.99, @order.total
      end
    end
  end
  context "order with two £12.99 items in its cart" do
    setup do
      cart = Cart.new
      product_line = Factory.build(:product_line,:price => 12.99)
      option = Factory.build(:option,:product_line => product_line)
      cart.add_item(option,2)
      @order = Order.new({:cart => cart})
    end
    should "have a subtotal of £25.98" do
      assert_equal 25.98, @order.subtotal
    end
  end
  context "order with one £12.99 item and one £6.99 item in its cart" do
    setup do
      cart = Cart.new
      product_line = Factory.build(:product_line,:price => 12.99)
      option = Factory.build(:option,:product_line => product_line)
      cart.add_item(option,1)
      product_line = Factory.build(:product_line,:price => 6.99)
      option = Factory.build(:option,:product_line => product_line)
      cart.add_item(option,1)
      @order = Order.new({:cart => cart})
    end
    should "have a subtotal of £19.98" do
      assert_equal 19.98, @order.subtotal
    end
  end
  context "order with one £12.99 item in its cart and £2.99 shipping method" do
    setup do
      cart = Cart.new
      product_line = Factory.build(:product_line,:price => 12.99)
      option = Factory.build(:option,:product_line => product_line)
      cart.add_item(option,1)
      @order = Order.new({:cart => cart,:shipping_method => Factory.build(:shipping_method,:price => 2.99)})
    end
    should "have a total of £15.98" do
      assert_equal 15.98, @order.total
    end
    should "have a total_as_int of 1598" do
      assert_equal 1598, @order.total_as_int
    end
    context "that has been credited £12.99" do
      setup do
        @order.order_credit = 12.99
      end
      should "have a value of £2.99" do
        assert_equal 2.99, @order.value
      end
    end
  end
  context "order with billing information" do
    setup do
      @card_original = Factory.build(:mastercard, {:month => '7'})
      @order = Order.new({:card_number => @card_original.number, :card_type => @card_original.type, :card_start_date => Date.parse("#{@card_original.start_month}/#{@card_original.start_year}"), :card_expiry_date => Date.parse("#{@card_original.month}/#{@card_original.year}"), :card_verification_value => @card_original.verification_value, :card_issue_number => @card_original.issue_number, :billing_firstname => 'David', :billing_lastname => 'Cameron'})
    end
    should "return a credit_card" do
      assert_instance_of ActiveMerchant::Billing::CreditCard, @order.credit_card
    end
    should "return a credit_card from billing information" do
      assert_equal @order.credit_card.number, @card_original.number
      assert_equal @order.credit_card.type, @card_original.type
      assert_equal @order.credit_card.month, @card_original.month.to_i              # integer conversion?
      assert_equal @order.credit_card.year, @card_original.year.to_i                # integer conversion?
      assert_equal @order.credit_card.start_month, @card_original.start_month.to_i  # integer conversion?
      assert_equal @order.credit_card.start_year, @card_original.start_year.to_i    # integer conversion?
      assert_equal @order.credit_card.verification_value, @card_original.verification_value
      assert_equal @order.credit_card.issue_number, @card_original.issue_number
      assert_equal @order.credit_card.first_name, 'David'
      assert_equal @order.credit_card.last_name, 'Cameron'
    end
    context "that has clear_card_data called" do
      setup do
        @order.clear_card_data
      end
      should "return a blank credit card" do
        assert_nil @order.credit_card.number
        assert_nil @order.credit_card.type
        assert_nil @order.credit_card.month
        assert_nil @order.credit_card.year
        assert_nil @order.credit_card.start_month
        assert_nil @order.credit_card.start_year
        assert_nil @order.credit_card.verification_value
        assert_nil @order.credit_card.issue_number
      end
    end
  end
  context "order with no success responses" do
    setup do
      @order = Order.new
      @order.save(false)
    end
    should "report status as ''" do
      assert_equal '', @order.status
    end
  end
  context "order with success responses up to enrollment_check" do
    setup do
      Order.any_instance.stubs(:enrollment_check_response).returns(ActiveMerchant::Billing::PayflowUKCardinalResponse.new)
      ActiveMerchant::Billing::PayflowUKCardinalResponse.any_instance.stubs(:success?).returns(true)
      @order = Order.new
      @order.save(false)
    end
    should "report status as 'checked'" do
      assert_equal 'checked', @order.status
    end
  end
  context "order with  success responses up to authenticate" do
    setup do
      Order.any_instance.stubs(:authenticate_response).returns(ActiveMerchant::Billing::PayflowUKCardinalResponse.new)
      ActiveMerchant::Billing::PayflowUKCardinalResponse.any_instance.stubs(:success?).returns(true)
      @order = Order.new
      @order.save(false)
    end
    should "report status as 'authenticated'" do
      assert_equal 'authenticated', @order.status
    end
  end
  context "order with success responses up to 'authorize'" do
    setup do
      Order.any_instance.stubs(:authorize_response).returns(ActiveMerchant::Billing::PayflowResponse.new(nil,nil))
      ActiveMerchant::Billing::PayflowResponse.any_instance.stubs(:success?).returns(true)
      @order = Order.new
      @order.save(false)
    end
    should "report status as 'authorized'" do
      assert_equal 'authorized', @order.status
    end
  end
  context "order with success responses up to 'capture'" do
    setup do
      Order.any_instance.stubs(:capture_response).returns(ActiveMerchant::Billing::PayflowResponse.new(nil,nil))
      ActiveMerchant::Billing::PayflowResponse.any_instance.stubs(:success?).returns(true)
      @order = Order.new
      @order.save(false)
    end
    should "report status as 'captured'" do
      assert_equal 'captured', @order.status
    end
  end
  context "order with success responses up to 'dispatched'" do
    setup do
      Order.any_instance.stubs(:dispatch_called_at).returns(DateTime.now)
      @order = Order.new
      @order.save(false)
    end
    should "report status as 'dispatched'" do
      assert_equal 'dispatched', @order.status
    end
  end
  context "order with success responses up to 'void'" do
    setup do
      Order.any_instance.stubs(:void_response).returns(ActiveMerchant::Billing::PayflowResponse.new(nil,nil))
      ActiveMerchant::Billing::PayflowResponse.any_instance.stubs(:success?).returns(true)
      @order = Order.new
      @order.save(false)
    end
    should "report status as 'voided'" do
      assert_equal 'voided', @order.status
    end
  end
  context "order with success responses up to 'credit'" do
    setup do
      Order.any_instance.stubs(:credit_response).returns(ActiveMerchant::Billing::PayflowResponse.new(nil,nil))
      ActiveMerchant::Billing::PayflowResponse.any_instance.stubs(:success?).returns(true)
      @order = Order.new
      @order.save(false)
    end
    should "report status as 'credited'" do
      assert_equal 'credited', @order.status
    end
  end
  context "order with a transaction type of 'Cash (Manual)'" do
    setup do
      @order = Factory.build(:order, :transaction_type => 'Cash (Manual)')
    end
    should 'return true to manual?' do
      assert_equal true, @order.manual?
    end
  end
  context "order with no transaction type" do
    setup do
      @order = Factory.build(:order, :transaction_type => nil)
    end
    should 'return false to manual?' do
      assert_equal false, @order.manual?
    end
  end
end

