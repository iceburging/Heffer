Feature: Manage Orders
  In order to get orders out to customers
  As an administrator
  I want to accept, reject, dispatch, capture, refund and void orders

  Scenario: View active orders
    Given I am logged in as admin
    And I have '1' enrollment checked order
    And I have '1' authenticated order
    And I have '1' authorized order
    And I have '1' captured order
    When I go to the active orders page
    Then I should see "01/01/01" within "#enrollment_checked_orders"
    And I should see "02/01/01" within "#authenticated_orders"
    And I should see "03/01/01" within "#authorized_orders"
    And I should see "04/01/01" within "#captured_orders"

  Scenario: Collect a payment, dispatch the item and then make a full refund
    Given a user has placed an authorized order
    And I am logged in as admin
    When I go to the active orders page
    And I follow "details" within "#authorized_orders"
    Then I should see "Status: authorized"
    When I press "Collect Payment"
    Then I should see "Status: captured"
    When I press "Dispatch"
    Then I should see "Status: dispatched"
    When I fill in "amount" with "9.99"
    And I press "Refund"
    Then I should see "Status: credited"
    And I should see "There are no actions left to perform on this order."
    And I should see "£9.99 of this order has been refunded resulting in a value of £0.00."

  Scenario: Void an order
    Given a user has placed an authorized order
    And I am logged in as admin
    When I go to the active orders page
    And I follow "details" within "#authorized_orders"
    Then I should see "Status: authorized"
    When I press "Void Order"
    Then I should see "Status: voided"
    And I should see "There are no actions left to perform on this order."
    And I should not see "this order has been refunded"

  Scenario: View completed orders
    Given I am logged in as admin
    And I have '1' dispatched order
    And I have '1' refunded order
    And I have '1' voided order
    When I go to the completed orders page
    Then I should see "05/01/01" within "#dispatched_orders"
    And I should see "06/01/01" within "#refunded_orders"
    And I should see "07/01/01" within "#voided_orders"

  Scenario: View inactive orders
    Given I am logged in as admin
    And I have '1' inactive enrollment checked order
    And I have '1' inactive authenticated order
    And I have '1' inactive authorized order
    And I have '1' inactive captured order
    And I have '1' inactive dispatched order
    And I have '1' inactive refunded order
    And I have '1' inactive voided order
    When I go to the inactive orders page
    Then I should see "checked"
    And I should see "authenticated"
    And I should see "authorized"
    And I should see "captured"
    And I should see "dispatched"
    And I should see "credited"
    And I should see "voided"

  Scenario: View cart for manual order
    Given I am logged in as admin
    And I have added an example product to the cart
    When I go to the private index page
    And I follow "ORDERS"
    And I follow "Place Manual Order"
    Then I should see "MyString"
    And I should see "9.99"

  Scenario: Update cart item quantity for manual order
    Given I am logged in as admin
    And I have added an example product to the cart
    When I go to the private index page
    And I follow "ORDERS"
    And I follow "Place Manual Order"
    Then the field named "cart[items][][quantity]" should contain "1"
    When I fill in "cart[items][][quantity]" with "2"
    And press "Update Basket"
    Then the field named "cart[items][][quantity]" should contain "2"

  Scenario: Remove cart item for manual order
    Given I am logged in as admin
    And I have added an example product to the cart
    When I go to the private index page
    And I follow "ORDERS"
    And I follow "Place Manual Order"
    Then the field named "cart[items][][quantity]" should contain "1"
    When I follow "remove"
    Then I should see "Basket Empty"

  Scenario: Apply discount to manual order
    Given I am logged in as admin
    And I have added an example product to the cart
    When I go to the private index page
    And I follow "ORDERS"
    And I follow "Place Manual Order"
    And I fill in "order[discount_description]" with "My Discount"
    And I fill in "order[discount_value]" with "5.50"
    When I press "Update Basket"
    Then I should see "4.49"
    And the field named "order[discount_description]" should contain "My Discount"
    And the field named "order[discount_value]" should contain "5.50"

  Scenario: Set shipping method on manual order
    Given I am logged in as admin
    And I have added an example product to the cart
    When I go to the private index page
    And I follow "ORDERS"
    And I follow "Place Manual Order"
    And I fill in "shipping_method[name]" with "My Shipping"
    And I fill in "shipping_method[price]" with "2.50"
    When I press "Update Basket"
    Then I should see "12.49"
    And the field named "shipping_method[name]" should contain "My Shipping"
    And the field named "shipping_method[price]" should contain "2.50"

  Scenario: Create manual order
    Given I am logged in as admin
    And I have added an example product to the cart
    When I go to the private index page
    And I follow "ORDERS"
    And I follow "Place Manual Order"
    And I fill in "shipping_method[name]" with "My Shipping"
    And I fill in "shipping_method[price]" with "2.50"
    And I press "Update Basket"
    And I fill in "order[order_ref]" with "ADTEST01"
    And I select "Cash " from "Transaction Type"
    And I press "Place Order"
    Then I should see "ADTEST01"

  Scenario: Collect a payment, dispatch the item and then make a full refund on a manual order
    Given a manual order has been placed
    And I am logged in as admin
    When I go to the active orders page
    And I follow "details" within "#authorized_orders"
    Then I should see "Status: authorized"
    When I press "Collect Payment"
    Then I should see "Status: captured"
    When I press "Dispatch"
    Then I should see "Status: dispatched"
    When I fill in "amount" with "9.99"
    And I press "Refund"
    Then I should see "Status: credited"
    And I should see "There are no actions left to perform on this order."
    And I should see "£9.99 of this order has been refunded resulting in a value of £2.50."

  Scenario: Void a manual order
    Given a manual order has been placed
    And I am logged in as admin
    When I go to the active orders page
    And I follow "details" within "#authorized_orders"
    Then I should see "Status: authorized"
    When I press "Void Order"
    Then I should see "Status: voided"
    And I should see "There are no actions left to perform on this order."
    And I should not see "this order has been refunded"

