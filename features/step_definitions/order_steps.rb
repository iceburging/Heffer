Given /^I have '1' (|inactive )enrollment checked order$/ do |value|
  if value == 'inactive '
    Factory.create(:order_enrollment_checked, :active => false)
  else
    Factory.create(:order_enrollment_checked)
  end
end

Given /^I have '1' (|inactive )authenticated order$/ do |value|
  if value == 'inactive '
    Factory.create(:order_authenticated, :active => false)
  else
    Factory.create(:order_authenticated)
  end
end

Given /^I have '1' (|inactive )authorized order$/ do |value|
  if value == 'inactive '
    Factory.create(:order_authorized, :active => false)
  else
    Factory.create(:order_authorized)
  end
end

Given /^I have '1' (|inactive )captured order$/ do |value|
  if value == 'inactive '
    Factory.create(:order_captured, :active => false)
  else
    Factory.create(:order_captured)
  end
end

Given /^I have '1' (|inactive )dispatched order$/ do |value|
  if value == 'inactive '
    Factory.create(:order_dispatched, :active => false)
  else
    Factory.create(:order_dispatched)
  end
end

Given /^I have '1' (|inactive )refunded order$/ do |value|
  if value == 'inactive '
    Factory.create(:order_refunded, :active => false)
  else
    Factory.create(:order_refunded)
  end
end

Given /^I have '1' (|inactive )voided order$/ do |value|
  if value == 'inactive '
    Factory.create(:order_voided, :active => false)
  else
    Factory.create(:order_voided)
  end
end

Given /^a user has placed an authorized order$/ do
  Given 'I have added an example product to the cart'
  And 'I have chosen a shipping destination'
  And 'I have selected a shipping method'
  And 'I have agreed to the terms and conditions'
  When 'I press "Proceed to Checkout"'
  And 'I fill in my delivery address'
  And 'I press "Continue"'
  When 'I fill in my billing address'
  And 'I fill in my contact details'
  And 'I fill in my "Mastercard" card details for "not enrolled" response'
  When 'I press "Place Order"'
end

Given /^a manual order has been placed$/ do
  Given 'I am logged in as admin'
  And 'I have added an example product to the cart'
  When 'I go to the private index page'
  And 'I follow "ORDERS"'
  And 'I follow "Place Manual Order"'
  And 'I fill in "shipping_method[name]" with "My Shipping"'
  And 'I fill in "shipping_method[price]" with "2.50"'
  And 'I press "Update Basket"'
  And 'I fill in "order[order_ref]" with "ADTEST01"'
  And 'I select "Cash " from "Transaction Type"'
  And 'I press "Place Order"'
end

Then /^debug$/ do
  p Order.find(:all)
  p Order.find(:first).manual?
  p Order.find(:first).transaction_type
end

