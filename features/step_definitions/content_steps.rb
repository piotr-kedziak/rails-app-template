Then(/^I should see "([^"]*)"$/) do |content|
  expect(page).to have_content(content)
end

Then(/^I shouldn't see "([^"]*)"$/) do |content|
  expect(page).not_to have_content(content)
end
