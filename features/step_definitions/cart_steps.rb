Given /^The following item[s] in the cart$/ do |table|
  table.hashes.each do |hash|
    hash.each do |key, value|
      case key
      when 'option'
        options_values = value.split(', ')
        option_hash = {:size => options_values[0], :colour => options_values[1], :available => options_values[2]}.delete_if{|key,value| value.nil? }
        hash[key] = Factory.create(:option,option_hash)
      end
    end
    @cart.add_item(hash['option'],hash['quantity'])
  end
end

Given /^I have added an example product to the cart$/ do
  Given 'An example product exists'
  And 'I am on the home page'
  When 'I follow "products"'
  And 'I follow "more details"'
  And 'I press "add"'
end

Given /^I have added (\d+) example product[s] to the cart$/ do |number|
  Given 'An example product exists'
  And 'I am on the home page'
  When 'I follow "products"'
  And 'I follow "more details"'
  steps %Q{
    And I fill in "quantity" with "#{number}"
  }
  And 'I press "add"'
end

Given /^I have chosen a shipping destination$/ do
  Given "The following country records", table(%{
    |      name      | iso_code |
    | United Kingdom |    GB    |
    })
  And "The following shipping method records", table(%{
    |   name   |price |   countries    |
    | Free UK  | 0.00 | United Kingdom |
    | Rapid UK | 5.99 | United Kingdom |
    })
  And 'I am on the home page'
  When 'I follow "checkout"'
  And 'I select "United Kingdom" from "order[delivery_country]"'
  And 'I press "Go"'
end

Given /^I have selected a shipping method$/ do
  Given 'I am on the show cart page'
  When 'I select "Free UK" from "order[shipping_method]"'
  And 'I press "Update Basket"'
end

Given /^I have agreed to the terms and conditions$/ do
  Given 'I am on the show cart page'
  When 'I check "accept"'
end

When /^I fill in my delivery address$/ do
  When 'I fill in "Firstname" with "David"'
  And 'I fill in "Lastname" with "Cameron"'
  And 'I fill in "Line 1" with "10"'
  And 'I fill in "Line 2" with "Downing Street"'
  And 'I fill in "Town" with "London"'
  And 'I fill in "County" with "Greater London"'
  And 'I fill in "Postcode" with "SW1A 2AA"'
end

When /^I fill in my billing address$/ do
  When 'I fill in "Firstname" with "David"'
  And 'I fill in "Lastname" with "Cameron"'
  And 'I fill in "Line 1" with "10"'
  And 'I fill in "Line 2" with "Downing Street"'
  And 'I fill in "Town" with "London"'
  And 'I fill in "County" with "Greater London"'
  And 'I select "United Kingdom" from "order[billing_country]"'
  And 'I fill in "Postcode" with "SW1A 2AA"'
end

When /^I fill in a blank billing address$/ do
  When 'I fill in "Firstname" with ""'
  And 'I fill in "Lastname" with ""'
  And 'I fill in "Line 1" with ""'
  And 'I fill in "Line 2" with ""'
  And 'I fill in "Town" with ""'
  And 'I fill in "County" with ""'
  And 'I select "" from "order[billing_country]"'
  And 'I fill in "Postcode" with ""'
end

When /^I fill in my contact details$/ do
  When 'I fill in "Email" with "d.cameron@number10.gov.uk"'
  And 'I fill in "Telephone Number" with "02079250918"'
end

When /^I fill in my "([^\"]*)" card details for "([^\"]*)" response$/ do |card_type,test_type|
  card_type = card_type.sub(' ','_').downcase
  case test_type.downcase
  when 'authentication successful'
    card = Factory.build(card_type.to_sym, {:month => '1'})
  when 'authentication untrusted'
    card = Factory.build(card_type.to_sym, {:month => '2'})
  when 'authentication failed'
    card = Factory.build(card_type.to_sym, {:month => '3'})
  when 'authentication attempted'
    card = Factory.build(card_type.to_sym, {:month => '4'})
  when 'authentication unavailable'
    card = Factory.build(card_type.to_sym, {:month => '5'})
  when 'enrollement timeout'
    card = Factory.build(card_type.to_sym, {:month => '6'})
  when 'not enrolled'
    card = Factory.build(card_type.to_sym, {:month => '7'})
  when 'enrollment unavailable'
    card = Factory.build(card_type.to_sym, {:month => '8'})
  when 'enrollment error'
    card = Factory.build(card_type.to_sym, {:month => '10'})
  when 'authentication error'
    card = Factory.build(card_type.to_sym, {:month => '11'})
  else
    card = Factory.build(card_type.to_sym, {:month => '12'})
  end
  steps %Q{
    When I select "#{CARDTYPES.index(card.type)}" from "Card Type"
    And I fill in "Card Number" with "#{card.number}"
    And I select "#{card.start_month}/#{card.start_year}" as the formtastic "Start Date" date
    And I select "#{card.month}/#{card.year}" as the formtastic "Expiry Date" date
    And I fill in "CV2 Value" with "#{card.verification_value}"
    And I fill in "Issue Number" with "#{card.issue_number}"
  }
end

When /^I look at the frame named "([^\"]*)" I should see Processing your transaction$/ do |frame_name|
  within "iframe[name=#{frame_name}]" do |frame|
    frame_src = frame.dom.attributes["src"].value
    visit frame_src
    Then 'I should see "Processing your transaction"'
    Then 'show me the page'
  end
end

