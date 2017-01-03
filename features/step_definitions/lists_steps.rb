Then(/^I should see empty list information$/) do
  expect(page).to have_css('.jumbotron-empty')
end

Then(/^I should see "([^"]*)" list$/) do |name|
  expect(page).to have_css("table##{name}-list")
end

Then(/^I shouldn't see "([^"]*)" list$/) do |name|
  expect(page).not_to have_css("table##{name}-list")
end

Then(/^"([^"]*)" list should have (\d+) rows$/) do |list_name, count|
  expect(page).to have_css("table##{list_name}-list tbody tr", count: count.to_i)
end
