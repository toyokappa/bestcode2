FactoryBot.define do
  factory :user do
    provider { "github" }
    uid { Faker::Number.number digits: 13 }
    name { Faker::Internet.username }
    display_name { Faker::Name.name }
    email { Faker::Internet.safe_email }
    access_token { Faker::Internet.device_token }
  end
end
