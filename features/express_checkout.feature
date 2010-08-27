Feature: Express Checkout
  In order purchase some products
  As a customer
  I want to complete the express checkout process

  Scenario: Not agreed to terms and conditions
    Given I have added an example product to the cart
    And I have chosen a shipping destination
    And I have selected a shipping method
    When I press "Proceed to Paypal Express Checkout"
    Then I should see "Please agree to our terms and conditions before proceeding to the checkout"

  Scenario: Not selected a shipping method
    Given I have added an example product to the cart
    And I have chosen a shipping destination
    And I have agreed to the terms and conditions
    When I press "Proceed to Paypal Express Checkout"
    Then I should see "Shipping method can't be blank"

  Scenario: Getting through to paypal login
    Given I have added an example product to the cart
    And I have chosen a shipping destination
    And I have selected a shipping method
    And I have agreed to the terms and conditions
    When I press "Proceed to Paypal Express Checkout"
    Then I should see "You are being redirected"

    ####################################################
    # would like to go further but linking the paypal  #
    # account would break standard and 3d-secure flows #
    ####################################################

  Scenario: Successful return from paypal express
    Given a successful return from paypal express
    Then I should see "You are being redirected."
    # bug in webrat prevents following this redirect to invoice

