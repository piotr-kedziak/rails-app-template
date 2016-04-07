FactoryGirl.define do
  factory :user do
    sequence(:email)  { |n| "user-#{n}@example.com" }
    password "test123245"
    password_confirmation { |u| u.password }
  end
end
