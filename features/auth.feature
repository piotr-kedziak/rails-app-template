Feature: Authentication

  Scenario: Login form
    When I go to the homepage
    And I click link "login"
    Then I should see login form
    And I should see conditions info
    And I should see cookies info

    Scenario: Register
      When I go to the login page
      And I click link "register"
      Then I should see register form

    Scenario: Reset password
      When I go to the login page
      And I click link "forgot_password"
      Then I should see reset password form
