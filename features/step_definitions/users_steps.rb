Given(/^There aren't any users except me$/) do
  User.where.not(id: @user).destroy_all
end

Given(/^There are (\d+) other users$/) do |count|
  step "There aren't any users except me"
  FactoryGirl.create_list(:user, count.to_i)
end
