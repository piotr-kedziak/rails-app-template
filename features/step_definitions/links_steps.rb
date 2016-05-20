When(/^I click link "([^"]*)"$/) do |name|
  click_link name
end

When(/^I click i18n link "([^"]*)"$/) do |name|
  click_link I18n.t(name)
end

When(/^I click login link$/) do
  step "I click i18n link \"login\""
end

When(/^I click register link$/) do
  step "I click i18n link \"register\""
end

When(/^I click forgot password link$/) do
  step "I click i18n link \"forgot_password\""
end

Then(/^I should see link "([^"]*)"$/) do |name|
  expect(page).to have_link name
end

Then(/^I should see i18n link "([^"]*)"$/) do |name|
  step "I should see link \"#{I18n.t(name)}\""
end

Then(/^I shouldn't see link "([^"]*)"$/) do |name|
  expect(page).not_to have_link name
end

Then(/^I shouldn't see i18n link "([^"]*)"$/) do |name|
  step "I shouldn't see link \"#{I18n.t(name)}\""
end

Then(/^I should see login link$/) do
  step "I should see i18n link \"login\""
end

Then(/^I should see logout link$/) do
  step "I should see i18n link \"logout\""
end
