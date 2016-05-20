Given(/^There aren't any users except me$/) do
  User.where.not(id: @current_user).destroy_all
end

Given(/^There are (\d+) other users$/) do |count|
  step "There aren't any users except me"
  FactoryGirl.create_list(:user, count.to_i)
end

Then(/^I should see user "([^"]*)" field$/) do |field_name|
  step "I should see \"user_#{field_name}\" field"
end
