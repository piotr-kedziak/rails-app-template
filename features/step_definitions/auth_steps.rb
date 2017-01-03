Given(/^I am authenticated user$/) do
  @current_user = FactoryGirl.create(:user)

  step('I go to the login page')

  fill_in('user_email', with: @current_user.email)
  fill_in('user_password', with: @current_user.password)

  click_button I18n.t('login')
end

When(/^I click remove account button$/) do
  click_link I18n.t('users.registrations.destroy.destroy')
end

Then(/^I should see login form$/) do
  # login header info...
  expect(page).to have_content I18n.t('users.sessions.new.header')
  # and login button
  expect(page).to have_content I18n.t('login')
end

Then(/^I should see conditions info$/) do
  expect(page).to have_content I18n.t('users.sessions.new.conditions')
end

Then(/^I should see register form$/) do
  # register header info...
  expect(page).to have_content I18n.t('users.registrations.new.header')
  # and register button
  expect(page).to have_button I18n.t('register')
end

Then(/^I should see reset password form$/) do
  expect(page).to have_content I18n.t('users.passwords.new.header')
end

Then(/^My account schould be deleted$/) do
  expect(User.count).to eq(0)
end
