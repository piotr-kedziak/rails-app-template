FactoryGirl.define do
  factory :user do
    sequence(:email)      { |n| "user-#{n}@example.com" }
    sequence(:name)       { |n| "User #{n}" }
    password              { 'Qwert12345' }
    password_confirmation { |u| u.password }
    terms_accepted        true
  end
end
