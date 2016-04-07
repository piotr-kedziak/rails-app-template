When(/^I click link "([^"]*)"$/) do |name|
  click_link I18n.t(name)
end

Then(/^I should see link "([^"]*)"$/) do |name|
  page.has_link? I18n.t(name)
end
