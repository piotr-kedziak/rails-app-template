FactoryGirl.define do
  factory :user do
    name      { Faker::Name.name }
    email     { Faker::Internet.email }
    password  { Faker::Internet.password }
    password_confirmation { |u| u.password }

    terms_accepted    true
    cookies_accepted  true
  end
end
