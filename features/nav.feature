Feature: Navigation

  Scenario: Top nav
    Given I am authenticated user
    When I go to the home page
    Then I should see top navigation
    And I should see "dashboard" in navigation
    And I should see i18n link "logout"
