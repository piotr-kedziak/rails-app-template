Then(/^I should see top navigation$/) do
  expect(page).to have_css 'nav.navbar-fixed-top'
end

Then(/^I should see "([^"]*)" in navigation$/) do |name|
  expect(page).to have_link I18n.t(".nav.top.#{name}")
end

Then(/^I shouldn't see "([^"]*)" in navigation$/) do |name|
  expect(page).not_to have_link I18n.t(".nav.top.#{name}")
end

Then(/^I should see dashboard navigation link$/) do
  step "I should see \"dashboard\" in navigation"
end
