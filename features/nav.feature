Feature: Navigation

  Scenario: Top nav
    Given I am authenticated user
    When I go to the home page
    Then I should see top navigation
    And I should see dashboard navigation link
    And I should see logout link
