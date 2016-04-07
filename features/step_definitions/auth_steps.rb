Given(/^I am authenticated user$/) do
  @user = FactoryGirl.create(:user)

  step "I go to the login page"

  fill_in 'user_email', with: @user.email
  fill_in 'user_password', with: @user.password

  click_button I18n.t('login')
end

Then(/^I should see login form$/) do
  # login header info...
  page.has_content? I18n.t('users.sessions.new.header')
  # and login button
  page.has_content? I18n.t('login')
end

Then(/^I should see conditions info$/) do
  page.has_content? I18n.t('users.sessions.new.conditions')
end

Then(/^I should see cookies info$/) do
  page.has_content? I18n.t('users.sessions.new.cookies')
end

Then(/^I should see register form$/) do
  # register header info...
  page.has_content? I18n.t('users.registrations.new.header')
  # and register button
  page.has_content? I18n.t('register')
end

Then(/^I should see reset password form$/) do
  page.has_content? I18n.t('users.passwords.new.header')
end
