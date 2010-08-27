Feature: View Product
  In order to choose a product
  As a customer
  I want to view product information

  Scenario: View Product Outlines
    Given I have manufacturers named royce
    And The following product line records
    |manufacturer|   name  |             tag_line            |
    |    royce   |comfy bra|Supurb comfort at excellent price|
    When I go to the products page
    Then I should see "Royce" within ".product_in_list"
    And I should see "Comfy Bra" within ".product_in_list"
    And I should see "Supurb comfort at excellent price" within ".product_in_list"
    And I should see "£9.99" within ".product_in_list"

  Scenario: View Product Range
    Given An example product exists
    And The following product line records
    |manufacturer|      name      |               tag_line               |  range   |
    |  MyString  | Second Product | A product to test the range function | MyString |
    When I go to the products page
    And I follow "more details"
    Then I should see "Second Product"

