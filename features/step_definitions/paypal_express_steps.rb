Given /^a successful return from paypal express$/ do
  order = Order.new({:order_ref => 'EC-GGFG399I4D61WS6H6', :cart => Cart.new, :shipping_method => Factory.create(:shipping_method)})
  order.save(false)
  get(url_for(:controller => 'checkout', :action => 'express_authorize'),{:token => 'EC-GGFG399I4D61WS6H6', :PayerID => '7AKUSARZ7SAT8'})
end

When /^I am redirected to paypal express$/ do
  When 'I follow "Redirected"'
end

