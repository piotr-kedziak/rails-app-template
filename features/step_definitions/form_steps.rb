When(/^I click button "([^"]*)"$/) do |name|
  click_button(name)
end

When(/^I click i18n button "([^"]*)"$/) do |name|
  step("I click button \"#{I18n.t(name)}\"")
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in(field, with: value)
end

When(/^I choose option "([^"]*)" in "([^"]*)" select$/) do |option, select_list|
  select(option, from: select_list)
end

When(/^I choose i18n option "([^"]*)" in "([^"]*)" select$/) do |option, select_list|
  step("I choose option \"#{I18n.t(option)}\" in \"#{select_list}\" select")
end

When(/^I submit the form$/) do
  step('I click i18n button "send"')
end

Then(/^I should see "([^"]*)" field$/) do |name|
  expect(page).to have_field(name)
end

Then(/^I shouldn't see "([^"]*)" field$/) do |name|
  expect(page).not_to have_field(name)
end

Then(/^I should see "([^"]*)" select$/) do |name|
  expect(page).to have_select(name)
end

Then(/^I should see "([^"]*)" checkboxes$/) do |name|
  expect(page).to have_css("##{name}-checkboxes")
end
