When(/^I go to the home page$/) do
  visit root_path
end

When(/^I go to the login page$/) do
  visit new_user_session_path
end

When(/^I go to the register page$/) do
  visit new_user_registration_path
end

When(/^I go to edit my account page$/) do
  visit edit_user_registration_path
end
