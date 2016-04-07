Feature: Navigation

  Scenario: Top nav
    Given I am authenticated user
    When I go to the homepage
    Then I should see top navigation
    And I should see "dashboard" in navigation
    And I should see "logout" in navigation
