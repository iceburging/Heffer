Feature: News Items
  In order to inform customers
  As an admin
  I want add and view news items

  Scenario: Add and view a news item
    Given The following news items
    |title|               content              |
    |Horay|*New* site is just around the corner|
    When I go to the homepage
    Then I should see "Horay" within ".news_item"
    And I should see "New site is just around the corner" within ".news_item"
    Then show me the page

