Feature: Find Product
  In order to find a product
  As a customer
  I want to filter and browse products

  Scenario: List Products
    Given I have product lines named product1, product2
    When I go to the products page
    Then I should see "Product1"
    Then I should see "Product2"

  Scenario: List Products by Category
    Given I have categories titled jumper, skirt
    And The following product line records
    |   name  |category| flags |
    |my skirt |  skirt |       |
    |my jumper| jumper |       |
    When I go to the products page
    And I follow "Jumper"
    Then I should see "My Jumper"
    And I should not see "My Skirt"

  Scenario: List Products by Category and Filter
    Given I have categories titled jumper, skirt
    And I have flags titled long, short, woolen
    And The following product line records
    |     name    |category|    flags    |
    |   my skirt  |  skirt | long, woolen|
    |my mini skirt|  skirt |short, woolen|
    |  my jumper  | jumper |    woolen   |
    When I go to the products page
    Then I should see "Long" within "#filter_menu"
    When I follow "Skirt" within "#sub_menu"
    Then I should see "Long" within "#filter_menu"
    And I should see "Short" within "#filter_menu"
    And I should see "Woolen" within "#filter_menu"
    And I should see "My Mini Skirt"
    And I should see "My Skirt"
    And I should not see "My Jumper"
    When I follow "Short" within "#filter_menu"
    Then I should see "My Mini Skirt"
    And I should not see "My Skirt"
    And I should not see "My Jumper"

  Scenario: Add a product to the cart
    Given An example product exists
    And I am on the home page
    When I follow "products"
    Then I should see "Example"
    When I follow "more details"
    And I press "add"
    Then I should see "Added 1 item(s) to your cart."

