FactoryGirl.define do
  factory :user do
    sequence(:email)  { |n| "user-#{n}@example.com" }
    password "test123245"
    password_confirmation { |u| u.password }
    terms_accepted true
    cookies_accepted true
  end
end
