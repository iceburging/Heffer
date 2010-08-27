Feature: Manage Product Lines
  In order to offer product lines for sale
  As an administrator
  I want to add, remove and edit product lines

  Scenario: Add a Product Line and Options
    Given I have manufacturers named royce
    And I have categories titled bra
    And I have flags titled spoil yourself, rear fastening
    And I am logged in as admin
    And I am on the add product line page
    When I select "royce" from "manufacturer"
    And I select "bra" from "category"
    And I select "spoil yourself" from "flags"
    And I select "rear fastening" from "flags"
    And I fill in the following:
    | name | comfy bra |
    | description | a really comfortable item |
    | price | 15.89 |
    | tag line | comfort comes first |
    | prod no | A01 |
    | fabric | 100% cotton |
    And I fill in the following:
    | generator_size_a | 30 32 |
    | generator_size_b | A B |
    | generator_colour | Red Yellow |
    And I check "generator_available"
    And I press "Add Options"
    Then I should see "New options added."
    And the field named "product_line[options_attributes][0][size]" should contain "30 A"
    When I fill in the following:
    | generator_size_a | 34 |
    | generator_size_b | A B |
    | generator_colour | Red Yellow |
    And I check "generator_available"
    And I press "Add Options"
    Then I should see "New options added."
    When I fill in the following:
    | generator_size_a | 34 |
    | generator_size_b | D |
    | generator_colour | Red Yellow |
    And I check "generator_available"
    And I press "Replace Options"
    Then I should see "Options ammended."

