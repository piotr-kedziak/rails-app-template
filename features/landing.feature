Feature: Landing page

  Scenario: Login link on landing page
    When I go to the home page
    Then I should see i18n link "login"
