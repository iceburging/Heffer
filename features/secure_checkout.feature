Feature: Secure Checkout
  In order purchase some products
  As a customer
  I want to complete the secure checkout process

  Scenario: Completed billing address details (mastercard secure)
    Given I have added an example product to the cart
    And I have chosen a shipping destination
    And I have selected a shipping method
    And I have agreed to the terms and conditions
    When I press "Proceed to Checkout"
    And I fill in my delivery address
    And I press "Continue"
    When I fill in my billing address
    And I fill in my contact details
    And I fill in my "Mastercard" card details for "authentication successful" response
    And I press "Place Order"
    And I look at the frame named "auth_frame" I should see Processing your transaction

