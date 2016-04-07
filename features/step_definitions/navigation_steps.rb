When(/^I go to the homepage$/) do
  visit root_path
end

When(/^I go to the login page$/) do
  visit new_user_session_path
end
