Feature: Cart
  In order to order the correct products
  As a customer
  I want to view, edit and update the cart

  Scenario: No Items In Cart
    When I go to the show cart page
    Then I should see "your cart is currently empty"

  Scenario: Set Delivery Country
    Given The following country records
    |      name      | iso_code |
    | United Kingdom |    GB    |
    And The following shipping method records
    |  name   |price |   countries    |
    | Free UK | 0.00 | United Kingdom |
    And I have added an example product to the cart
    When I follow "checkout"
    Then I should see "Please enter the country you would like your chosen products to be shipped to"
    And I should see "United Kingdom" within "#order_delivery_country"

  Scenario: View Cart
    Given I have added an example product to the cart
    And I have chosen a shipping destination
    When I go to the show cart page
    Then I should see "Shipping to United Kingdom"
    And I should see "Example"
    And I should see "Free UK" within "#order_shipping_method"

  Scenario: Remove Only Cart Item
    Given I have added an example product to the cart
    And I have chosen a shipping destination
    When I go to the show cart page
    And I follow "remove"
    Then I should see "your cart is currently empty"

  Scenario: Update Cart Item Quantity
    Given I have added 2 example products to the cart
    And I have chosen a shipping destination
    When I go to the show cart page
    Then the field named "cart[items][][quantity]" should contain "2"
    When I fill in "cart[items][][quantity]" with "1"
    And press "Update Basket"
    Then the field named "cart[items][][quantity]" should contain "1"

  Scenario: Update Cart Shipping Method
    Given I have added an example product to the cart
    And I have chosen a shipping destination
    And I have selected a shipping method
#    Then the field named "order[shipping_method]" should contain "Free UK"
    Then "Free UK" should be selected for the field named "order[shipping_method]"
    When I select "Rapid UK" from "order[shipping_method]"
    And I press "Update Basket"
#    Then the field named "order[shipping_method]" should contain "Rapid UK"
    Then "Rapid UK" should be selected for the field named "order[shipping_method]"

