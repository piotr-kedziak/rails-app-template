Then(/^I should see top navigation$/) do
  expect(page).to have_css 'nav.navbar-fixed-top'
end

Then(/^I should see "([^"]*)" in navigation$/) do |name|
  expect(page).to have_css 'nav.navbar .logout'
  step "I should see link \"name\""
end
