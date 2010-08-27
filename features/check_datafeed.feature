Feature: Datafeeds
  In order advertise widely
  As an admin
  I want to provide a sitemap and product data feed

  Scenario: Check product feed
    Given A sensible example product exists
    When I go to the products feed page
    Then I should see "Autumn 01"
    And I should see "Embrace the Autumn weather"
    And I should see "9.99"
    And I should see "P01"
    And I should see "Visa"
    And I should see "MasterCard"
    And I should see "N01"
    And I should see "new"
    And I should see "Nike"

  Scenario: Check sitemap
    Given I have created a page
    And A sensible example product exists
    When I go to the sitemap page
    Then check for presence of website address
    And I should see "my_menu"
    And I should see "test_page"
    And I should see "monthly"
    And I should see "products/details"
    And I should see "1.0"

