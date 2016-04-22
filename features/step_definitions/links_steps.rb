When(/^I click link "([^"]*)"$/) do |name|
  click_link name
end

When(/^I click i18n link "([^"]*)"$/) do |name|
  click_link I18n.t(name)
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
