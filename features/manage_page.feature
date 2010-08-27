Feature: Manage Pages
  In order to provide content
  As an admin
  I want manage and view pages

  Scenario: Create and view two pages with the same title
    Given I have a menu entry titled "first menu"
    And I have a menu entry titled "second menu"
    When I go to the create page page
    And I select "first menu" from "Menu Entry"
    And I fill in "Title" with "test page"
    And I fill in "Position" with "1"
    And I fill in "Content" with "this is the first menu test page"
    And I press "Create"
    And I go to the create page page
    And I select "second menu" from "Menu Entry"
    And I fill in "Title" with "test page"
    And I fill in "Position" with "1"
    And I fill in "Content" with "this is the second menu test page"
    And I press "Create"
    And I visit the "test page" semi-static page in the "first menu" menu
    Then I should see "this is the first menu test page"
    When I visit the "test page" semi-static page in the "second menu" menu
    Then I should see "this is the second menu test page"

  Scenario: Create and view a homepage
    When I go to the homepage
    Then I should see the default message
    When I go to the create page page
    And I fill in "Title" with "homepage"
    And I fill in "Position" with "1"
    And I fill in "Content" with "this is my homepage"
    And I press "Create"
    And I go to the homepage
    Then I should see "this is my homepage"

  Scenario: Create and view a site page with no menu entry
    When I go to the create page page
    And I fill in "Title" with "legal"
    And I fill in "Position" with "1"
    And I fill in "Content" with "some legal blurb goes here"
    And I press "Create"
    And I go to the homepage
    And I follow "legal"
    Then I should see "some legal blurb goes here"

