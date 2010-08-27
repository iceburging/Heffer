Feature: Standard Checkout
  In order purchase some products
  As a customer
  I want to complete the standard checkout process

  Scenario: Not agreed to terms and conditions
    Given I have added an example product to the cart
    And I have chosen a shipping destination
    And I have selected a shipping method
    When I press "Proceed to Checkout"
    Then I should see "Please agree to our terms and conditions before proceeding to the checkout"

  Scenario: Not selected a shipping method
    Given I have added an example product to the cart
    And I have chosen a shipping destination
    And I have agreed to the terms and conditions
    When I press "Proceed to Checkout"
    Then I should see "Shipping method can't be blank"

  Scenario: Not completed delivery details
    Given I have added an example product to the cart
    And I have chosen a shipping destination
    And I have selected a shipping method
    And I have agreed to the terms and conditions
    When I press "Proceed to Checkout"
    And I press "Continue"
    Then I should see "Delivery Details"

  Scenario: Completed delivery address details
    Given I have added an example product to the cart
    And I have chosen a shipping destination
    And I have selected a shipping method
    And I have agreed to the terms and conditions
    When I press "Proceed to Checkout"
    Then I should see "Delivery Details"
    When I fill in my delivery address
    And I press "Continue"
    Then I should see "Billing Details"

  Scenario: Not completed billing address details
    Given I have added an example product to the cart
    And I have chosen a shipping destination
    And I have selected a shipping method
    And I have agreed to the terms and conditions
    When I press "Proceed to Checkout"
    And I fill in my delivery address
    And I press "Continue"
    Then I should see "Billing Details"
    And the "Firstname" field should contain "David"
    And the "Country" field should contain "United Kingdom"
    And I fill in a blank billing address
    When I press "Place Order"
    Then I should see "Billing Details"

  Scenario: Completed billing address details (mastercard non-secure)
    Given I have added an example product to the cart
    And I have chosen a shipping destination
    And I have selected a shipping method
    And I have agreed to the terms and conditions
    When I press "Proceed to Checkout"
    And I fill in my delivery address
    And I press "Continue"
    When I fill in my billing address
    And I fill in my contact details
    And I fill in my "Mastercard" card details for "not enrolled" response
    When I press "Place Order"
    Then I should see "Invoice"
    And a confirmation email should be dispatched to "d.cameron@number10.gov.uk"

