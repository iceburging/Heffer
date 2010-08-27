Feature: Test Custom Textile
  In order include nice content
  As an admin
  I want use custom textile methods

  Scenario: Create page with a partial
    Given I have a menu entry titled "my menu"
    When I go to the create page page
    And I select "my menu" from "Menu Entry"
    And I fill in "Title" with "test page"
    And I fill in "Position" with "1"
    And I fill in "Content" with "partial. test"
    And I press "Create"
    And I visit the "test page" semi-static page in the "my menu" menu
    Then I should see "icecream tastes WELL nice"

  Scenario: Create page with a link using a site page reference
    Given I have a menu entry titled "my menu"
    When I go to the create page page
    And I select "my menu" from "Menu Entry"
    And I fill in "Title" with "test page"
    And I fill in "Position" with "1"
    And I fill in "Content" with textile body
       """
       this is a "link":~target_page
       """
    And I press "Create"
    When I go to the create page page
    And I select "my menu" from "Menu Entry"
    And I fill in "Title" with "target page"
    And I fill in "Position" with "1"
    And I fill in "Content" with "this is the target page"
    And I press "Create"
    And I visit the "target page" semi-static page in the "my menu" menu
    Then I should see "this is the target page"
    When I visit the "test page" semi-static page in the "my menu" menu
    And I follow "link"
    Then I should see "this is the target page"

  Scenario: Create page with a link using a site product reference
    Given I have a menu entry titled "my menu"
    And A sensible example product exists
    When I go to the create page page
    And I select "my menu" from "Menu Entry"
    And I fill in "Title" with "test page"
    And I fill in "Position" with "1"
    And I fill in "Content" with textile body
       """
       this is a "link":~P01
       """
    And I press "Create"
    And I visit the "test page" semi-static page in the "my menu" menu
    Then I should see "this is a link"
    When I follow "link"
    Then I should see "Autumn 01"

