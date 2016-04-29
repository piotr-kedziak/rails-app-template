Feature: Authentication

  Scenario: Login form
    When I go to the home page
    And I click i18n link "login"
    Then I should see login form

  Scenario: Register form
    When I go to the login page
    And I click i18n link "register"
    Then I should see register form
    And I should see "user_email" field
    And I should see "user_name" field

  Scenario: Reset password form
    When I go to the login page
    And I click i18n link "forgot_password"
    Then I should see reset password form

  Scenario: Delete own account
    Given I am authenticated user
    When I go to edit my account page
    And I click remove account button
    Then My account schould be deleted
