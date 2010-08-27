Factory.define :page do |p|
    p.title 'title'
    p.position  1
    p.content 'my page content'
end

Factory.define :manufacturer do |m|
  m.name 'MyString'
  m.telephone 'MyString'
  m.contact 'MyString'
  m.account 'MyString'
end

Factory.define :option do |o|
  o.size 'MyString'
  o.colour 'MyString'
  o.available 'false'
end

Factory.define :category do |c|
  c.position '1'
  c.title 'MyString'
  c.blurb 'MyText'
end

Factory.define :flag do |f|
  f.position '1'
  f.title 'MyString'
  f.blurb 'MyText'
end

Factory.define :product_line do |p|
  p.manufacturer_id ''
  p.category_id ''
  p.flags {|flags| [flags.association(:flag)]}
  p.options {|options| [options.association(:option)]}
  p.mfr_prod_no 'MyString'
  p.notes 'MyText'
  p.range 'MyString'
  p.name 'MyString'
  p.description 'MyText'
  p.tag_line 'MyText'
  p.prod_no 'MyString'
  p.fabric 'MyString'
  p.price '9.99'
end

Factory.define :product_line_with_category, :class => ProductLine do |p|
  p.manufacturer_id ''
  p.association :category
  p.flags {|flags| [flags.association(:flag)]}
  p.mfr_prod_no 'MyString'
  p.notes 'MyText'
  p.range 'MyString'
  p.name 'MyString'
  p.description 'MyText'
  p.tag_line 'MyText'
  p.prod_no 'MyString'
  p.fabric 'MyString'
  p.price '9.99'
end

Factory.define :order do |o|
  o.order_ref 'MyString'
  o.ip_address '0.0.0.0'
  o.status ''
  o.transaction_type ''
  o.cart ''
  o.shipping_method ''
  o.billing_firstname ''
  o.billing_lastname ''
  o.billing_line1 ''
  o.billing_line2 ''
  o.billing_town ''
  o.billing_county ''
  o.billing_country ''
  o.billing_postcode ''
  o.billing_email ''
  o.billing_telephone_number ''
  o.delivery_firstname ''
  o.delivery_lastname ''
  o.delivery_line1 ''
  o.delivery_line2 ''
  o.delivery_town ''
  o.delivery_county ''
  o.delivery_country ''
  o.delivery_postcode ''
  o.enrollment_check_response ''
  o.authenticate_response ''
  o.authorize_response ''
  o.capture_response ''
  o.void_response ''
  o.credit_response ''
  o.enrollment_check_called_at ''
  o.authenticate_called_at ''
  o.authorize_called_at ''
  o.capture_called_at ''
  o.void_called_at ''
  o.dispatch_called_at ''
  o.credit_called_at ''
  o.order_credit '0'
  o.active true
end

Factory.define :example_product, :class => ProductLine do |p|
  p.manufacturer {|manufacturer| manufacturer.association(:manufacturer)}
  p.category {|category| category.association(:category)}
  p.flags {|flags| [flags.association(:flag)]}
  p.options {|options| [options.association(:option)]}
  p.mfr_prod_no 'MyString'
  p.notes 'MyText'
  p.range 'MyString'
  p.name 'Example'
  p.description 'MyText'
  p.tag_line 'MyText'
  p.prod_no 'MyString'
  p.fabric 'MyString'
  p.price '9.99'
end

Factory.define :sensible_example_product, :class => ProductLine do |p|
  p.manufacturer {|manufacturer| manufacturer.association(:manufacturer, :name => 'Nike')}
  p.category {|category| category.association(:category, :title => 'Clothes')}
  p.flags {|flags| [flags.association(:flag, :title => 'Super')]}
  p.options {|options| [options.association(:option, :available => true)]}
  p.mfr_prod_no 'N01'
  p.notes 'Some notes'
  p.range 'Four Seasons'
  p.name 'Autumn 01'
  p.description 'Excellent Autumnal product in orange hues'
  p.tag_line 'Embrace the Autumn weather'
  p.prod_no 'P01'
  p.fabric 'Cotton'
  p.price '9.99'
end

Factory.define :completed_order, :class => Order do |o|
  o.order_ref 'EN12345TRX12'
  o.ip_address '0.0.0.0'
  o.status ''
  o.transaction_type ''
  o.cart ''
  o.shipping_method {|shipping_method| shipping_method.association(:shipping_method)}
  o.billing_firstname 'David'
  o.billing_lastname 'Cameron'
  o.billing_line1 '10'
  o.billing_line2 'Downing Street'
  o.billing_town 'London'
  o.billing_county 'Greater London'
  o.billing_country 'United Kingdom'
  o.billing_postcode 'SW1A 2AA'
  o.billing_email 'd.cameron@number10.gov.uk'
  o.billing_telephone_number '02079250918'
  o.delivery_firstname 'David'
  o.delivery_lastname 'Cameron'
  o.delivery_line1 '10'
  o.delivery_line2 'Downing Street'
  o.delivery_town 'London'
  o.delivery_county 'Greater London'
  o.delivery_country 'United Kingdom'
  o.delivery_postcode 'SW1A 2AA'
  o.enrollment_check_response nil
  o.authenticate_response nil
  o.authorize_response nil
  o.capture_response nil
  o.void_response nil
  o.credit_response nil
  o.enrollment_check_called_at nil
  o.authenticate_called_at nil
  o.authorize_called_at nil
  o.capture_called_at nil
  o.void_called_at nil
  o.dispatch_called_at nil
  o.credit_called_at nil
  o.order_credit '0'
  o.active true
end

Factory.define :order_enrollment_checked, :class => Order do |o|
  o.order_ref 'TEST-EN'
  o.ip_address '0.0.0.0'
  o.status 'Enrolled'
  o.transaction_type ''
  o.cart Cart.new
  o.shipping_method {|shipping_method| shipping_method.association(:shipping_method)}
  o.billing_firstname 'David'
  o.billing_lastname 'Cameron'
  o.billing_line1 '10'
  o.billing_line2 'Downing Street'
  o.billing_town 'London'
  o.billing_county 'Greater London'
  o.billing_country 'United Kingdom'
  o.billing_postcode 'SW1A 2AA'
  o.billing_email 'd.cameron@number10.gov.uk'
  o.billing_telephone_number '02079250918'
  o.delivery_firstname 'David'
  o.delivery_lastname 'Cameron'
  o.delivery_line1 '10'
  o.delivery_line2 'Downing Street'
  o.delivery_town 'London'
  o.delivery_county 'Greater London'
  o.delivery_country 'United Kingdom'
  o.delivery_postcode 'SW1A 2AA'
  o.enrollment_check_response ActiveMerchant::Billing::PayflowUKCardinalResponse.new(:error_no => '0')
  o.authenticate_response nil
  o.authorize_response nil
  o.capture_response nil
  o.void_response nil
  o.credit_response nil
  o.enrollment_check_called_at DateTime.parse('01-01-2001')
  o.authenticate_called_at nil
  o.authorize_called_at nil
  o.capture_called_at nil
  o.void_called_at nil
  o.dispatch_called_at nil
  o.credit_called_at nil
  o.order_credit '0'
  o.active true
end

Factory.define :order_authenticated, :class => Order do |o|
  o.order_ref 'TEST-AUT'
  o.ip_address '0.0.0.0'
  o.status 'Enrolled'
  o.transaction_type ''
  o.cart Cart.new
  o.shipping_method {|shipping_method| shipping_method.association(:shipping_method)}
  o.billing_firstname 'David'
  o.billing_lastname 'Cameron'
  o.billing_line1 '10'
  o.billing_line2 'Downing Street'
  o.billing_town 'London'
  o.billing_county 'Greater London'
  o.billing_country 'United Kingdom'
  o.billing_postcode 'SW1A 2AA'
  o.billing_email 'd.cameron@number10.gov.uk'
  o.billing_telephone_number '02079250918'
  o.delivery_firstname 'David'
  o.delivery_lastname 'Cameron'
  o.delivery_line1 '10'
  o.delivery_line2 'Downing Street'
  o.delivery_town 'London'
  o.delivery_county 'Greater London'
  o.delivery_country 'United Kingdom'
  o.delivery_postcode 'SW1A 2AA'
  o.enrollment_check_response ActiveMerchant::Billing::PayflowUKCardinalResponse.new(:error_no => '0')
  o.authenticate_response ActiveMerchant::Billing::PayflowUKCardinalResponse.new(:error_no => '0')
  o.authorize_response nil
  o.capture_response nil
  o.void_response nil
  o.credit_response nil
  o.enrollment_check_called_at DateTime.parse('01-01-2001')
  o.authenticate_called_at DateTime.parse('02-01-2001')
  o.authorize_called_at nil
  o.capture_called_at nil
  o.void_called_at nil
  o.dispatch_called_at nil
  o.credit_called_at nil
  o.order_credit '0'
  o.active true
end

Factory.define :order_authorized, :class => Order do |o|
  o.order_ref 'TEST-AZD'
  o.ip_address '0.0.0.0'
  o.status 'Enrolled'
  o.transaction_type ''
  o.cart Cart.new
  o.shipping_method {|shipping_method| shipping_method.association(:shipping_method)}
  o.billing_firstname 'David'
  o.billing_lastname 'Cameron'
  o.billing_line1 '10'
  o.billing_line2 'Downing Street'
  o.billing_town 'London'
  o.billing_county 'Greater London'
  o.billing_country 'United Kingdom'
  o.billing_postcode 'SW1A 2AA'
  o.billing_email 'd.cameron@number10.gov.uk'
  o.billing_telephone_number '02079250918'
  o.delivery_firstname 'David'
  o.delivery_lastname 'Cameron'
  o.delivery_line1 '10'
  o.delivery_line2 'Downing Street'
  o.delivery_town 'London'
  o.delivery_county 'Greater London'
  o.delivery_country 'United Kingdom'
  o.delivery_postcode 'SW1A 2AA'
  o.enrollment_check_response ActiveMerchant::Billing::PayflowUKCardinalResponse.new(:error_no => '0')
  o.authenticate_response ActiveMerchant::Billing::PayflowUKCardinalResponse.new(:error_no => '0')
  o.authorize_response ActiveMerchant::Billing::PayflowResponse.new(true,'success!')
  o.capture_response nil
  o.void_response nil
  o.credit_response nil
  o.enrollment_check_called_at DateTime.parse('01-01-2001')
  o.authenticate_called_at DateTime.parse('02-01-2001')
  o.authorize_called_at DateTime.parse('03-01-2001')
  o.capture_called_at nil
  o.void_called_at nil
  o.dispatch_called_at nil
  o.credit_called_at nil
  o.order_credit '0'
  o.active true
end

Factory.define :order_captured, :class => Order do |o|
  o.order_ref 'TEST-CAP'
  o.ip_address '0.0.0.0'
  o.status 'Enrolled'
  o.transaction_type ''
  o.cart Cart.new
  o.shipping_method {|shipping_method| shipping_method.association(:shipping_method)}
  o.billing_firstname 'David'
  o.billing_lastname 'Cameron'
  o.billing_line1 '10'
  o.billing_line2 'Downing Street'
  o.billing_town 'London'
  o.billing_county 'Greater London'
  o.billing_country 'United Kingdom'
  o.billing_postcode 'SW1A 2AA'
  o.billing_email 'd.cameron@number10.gov.uk'
  o.billing_telephone_number '02079250918'
  o.delivery_firstname 'David'
  o.delivery_lastname 'Cameron'
  o.delivery_line1 '10'
  o.delivery_line2 'Downing Street'
  o.delivery_town 'London'
  o.delivery_county 'Greater London'
  o.delivery_country 'United Kingdom'
  o.delivery_postcode 'SW1A 2AA'
  o.enrollment_check_response ActiveMerchant::Billing::PayflowUKCardinalResponse.new(:error_no => '0')
  o.authenticate_response ActiveMerchant::Billing::PayflowUKCardinalResponse.new(:error_no => '0')
  o.authorize_response ActiveMerchant::Billing::PayflowResponse.new(true,'authorize success!')
  o.capture_response ActiveMerchant::Billing::PayflowResponse.new(true,'capture success!')
  o.void_response nil
  o.credit_response nil
  o.enrollment_check_called_at DateTime.parse('01-01-2001')
  o.authenticate_called_at DateTime.parse('02-01-2001')
  o.authorize_called_at DateTime.parse('03-01-2001')
  o.capture_called_at DateTime.parse('04-01-2001')
  o.void_called_at nil
  o.dispatch_called_at nil
  o.credit_called_at nil
  o.order_credit '0'
  o.active true
end

Factory.define :order_dispatched, :class => Order do |o|
  o.order_ref 'TEST-DIS'
  o.ip_address '0.0.0.0'
  o.status 'Enrolled'
  o.transaction_type ''
  o.cart Cart.new
  o.shipping_method {|shipping_method| shipping_method.association(:shipping_method)}
  o.billing_firstname 'David'
  o.billing_lastname 'Cameron'
  o.billing_line1 '10'
  o.billing_line2 'Downing Street'
  o.billing_town 'London'
  o.billing_county 'Greater London'
  o.billing_country 'United Kingdom'
  o.billing_postcode 'SW1A 2AA'
  o.billing_email 'd.cameron@number10.gov.uk'
  o.billing_telephone_number '02079250918'
  o.delivery_firstname 'David'
  o.delivery_lastname 'Cameron'
  o.delivery_line1 '10'
  o.delivery_line2 'Downing Street'
  o.delivery_town 'London'
  o.delivery_county 'Greater London'
  o.delivery_country 'United Kingdom'
  o.delivery_postcode 'SW1A 2AA'
  o.enrollment_check_response ActiveMerchant::Billing::PayflowUKCardinalResponse.new(:error_no => '0')
  o.authenticate_response ActiveMerchant::Billing::PayflowUKCardinalResponse.new(:error_no => '0')
  o.authorize_response ActiveMerchant::Billing::PayflowResponse.new(true,'authorize success!')
  o.capture_response ActiveMerchant::Billing::PayflowResponse.new(true,'capture success!')
  o.void_response nil
  o.credit_response nil
  o.enrollment_check_called_at DateTime.parse('01-01-2001')
  o.authenticate_called_at DateTime.parse('02-01-2001')
  o.authorize_called_at DateTime.parse('03-01-2001')
  o.capture_called_at DateTime.parse('04-01-2001')
  o.void_called_at nil
  o.dispatch_called_at DateTime.parse('05-01-2001')
  o.credit_called_at nil
  o.order_credit '0'
  o.active true
end

Factory.define :order_refunded, :class => Order do |o|
  o.order_ref 'TEST-REF'
  o.ip_address '0.0.0.0'
  o.status 'Enrolled'
  o.transaction_type ''
  o.cart Cart.new
  o.shipping_method {|shipping_method| shipping_method.association(:shipping_method)}
  o.billing_firstname 'David'
  o.billing_lastname 'Cameron'
  o.billing_line1 '10'
  o.billing_line2 'Downing Street'
  o.billing_town 'London'
  o.billing_county 'Greater London'
  o.billing_country 'United Kingdom'
  o.billing_postcode 'SW1A 2AA'
  o.billing_email 'd.cameron@number10.gov.uk'
  o.billing_telephone_number '02079250918'
  o.delivery_firstname 'David'
  o.delivery_lastname 'Cameron'
  o.delivery_line1 '10'
  o.delivery_line2 'Downing Street'
  o.delivery_town 'London'
  o.delivery_county 'Greater London'
  o.delivery_country 'United Kingdom'
  o.delivery_postcode 'SW1A 2AA'
  o.enrollment_check_response ActiveMerchant::Billing::PayflowUKCardinalResponse.new(:error_no => '0')
  o.authenticate_response ActiveMerchant::Billing::PayflowUKCardinalResponse.new(:error_no => '0')
  o.authorize_response ActiveMerchant::Billing::PayflowResponse.new(true,'authorize success!')
  o.capture_response ActiveMerchant::Billing::PayflowResponse.new(true,'capture success!')
  o.void_response nil
  o.credit_response ActiveMerchant::Billing::PayflowResponse.new(true,'credit success!')
  o.enrollment_check_called_at DateTime.parse('01-01-2001')
  o.authenticate_called_at DateTime.parse('02-01-2001')
  o.authorize_called_at DateTime.parse('03-01-2001')
  o.capture_called_at DateTime.parse('04-01-2001')
  o.void_called_at nil
  o.dispatch_called_at DateTime.parse('05-01-2001')
  o.credit_called_at DateTime.parse('06-01-2001')
  o.order_credit '9.99'
  o.active true
end

Factory.define :order_voided, :class => Order do |o|
  o.order_ref 'TEST-VOI'
  o.ip_address '0.0.0.0'
  o.status 'Enrolled'
  o.transaction_type ''
  o.cart Cart.new
  o.shipping_method {|shipping_method| shipping_method.association(:shipping_method)}
  o.billing_firstname 'David'
  o.billing_lastname 'Cameron'
  o.billing_line1 '10'
  o.billing_line2 'Downing Street'
  o.billing_town 'London'
  o.billing_county 'Greater London'
  o.billing_country 'United Kingdom'
  o.billing_postcode 'SW1A 2AA'
  o.billing_email 'd.cameron@number10.gov.uk'
  o.billing_telephone_number '02079250918'
  o.delivery_firstname 'David'
  o.delivery_lastname 'Cameron'
  o.delivery_line1 '10'
  o.delivery_line2 'Downing Street'
  o.delivery_town 'London'
  o.delivery_county 'Greater London'
  o.delivery_country 'United Kingdom'
  o.delivery_postcode 'SW1A 2AA'
  o.enrollment_check_response ActiveMerchant::Billing::PayflowUKCardinalResponse.new(:error_no => '0')
  o.authenticate_response ActiveMerchant::Billing::PayflowUKCardinalResponse.new(:error_no => '0')
  o.authorize_response ActiveMerchant::Billing::PayflowResponse.new(true,'authorize success!')
  o.capture_response nil
  o.void_response ActiveMerchant::Billing::PayflowResponse.new(true,'credit success!')
  o.credit_response nil
  o.enrollment_check_called_at DateTime.parse('01-01-2001')
  o.authenticate_called_at DateTime.parse('02-01-2001')
  o.authorize_called_at DateTime.parse('03-01-2001')
  o.capture_called_at nil
  o.void_called_at DateTime.parse('07-01-2001')
  o.dispatch_called_at nil
  o.credit_called_at nil
  o.order_credit '0'
  o.active true
end

Factory.define :country do |c|
  c.name 'MyString'
  c.iso_code 'MyString'
end

Factory.define :shipping_method do |s|
  s.name 'MyString'
  s.price '9.99'
end

# credit cards

Factory.define :visa, :class => ActiveMerchant::Billing::CreditCard do |c|
  c.add_attribute :type, 'visa'
  c.number '4111111111111111'
  c.verification_value '123'
  c.month Date.today.month
  c.year Date.today.year + 1
  c.start_month Date.today.month
  c.start_year Date.today.year - 1
  c.first_name ''
  c.last_name ''
  c.issue_number ''
end

Factory.define :mastercard, :class => ActiveMerchant::Billing::CreditCard do |c|
  c.add_attribute :type, 'master'
  c.number '5555555555554444'
  c.verification_value '123'
  c.month Date.today.month
  c.year Date.today.year + 1
  c.start_month Date.today.month
  c.start_year Date.today.year - 1
  c.first_name ''
  c.last_name ''
  c.issue_number ''
end

#Factory.define :american_express, :class => ActiveMerchant::Billing::CreditCard do |c|
#  c.add_attribute :type, 'american_express'
#  c.number '1'
#  c.verification_value '123'
#  c.month Date.today.month
#  c.year Date.today.year + 1
#  c.start_month Date.today.month
#  c.start_year Date.today.year - 1
#  c.first_name ''
#  c.last_name ''
#  c.issue_number ''
#end

#Factory.define :discover, :class => ActiveMerchant::Billing::CreditCard do |c|
#  c.add_attribute :type, 'discover'
#  c.number '1'
#  c.verification_value '123'
#  c.month Date.today.month
#  c.year Date.today.year + 1
#  c.start_month Date.today.month
#  c.start_year Date.today.year - 1
#  c.first_name ''
#  c.last_name ''
#  c.issue_number ''
#end

#Factory.define :solo, :class => ActiveMerchant::Billing::CreditCard do |c|
#  c.add_attribute :type, 'solo'
#  c.number '1'
#  c.verification_value '123'
#  c.month Date.today.month
#  c.year Date.today.year + 1
#  c.start_month Date.today.month
#  c.start_year Date.today.year - 1
#  c.first_name ''
#  c.last_name ''
#  c.issue_number ''
#end

#Factory.define :switch, :class => ActiveMerchant::Billing::CreditCard do |c|
#  c.add_attribute :type, 'switch'
#  c.number '1'
#  c.verification_value '123'
#  c.month Date.today.month
#  c.year Date.today.year + 1
#  c.start_month Date.today.month
#  c.start_year Date.today.year - 1
#  c.first_name ''
#  c.last_name ''
#  c.issue_number ''
#end

Factory.define :user do |u|
  u.name 'MyString'
  u.password 'MyPassword'
  u.password_confirmation 'MyPassword'
end

Factory.define :news_item do |n|
  n.title 'MyString'
  n.content 'MyText'
end

