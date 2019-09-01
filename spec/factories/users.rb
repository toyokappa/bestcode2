FactoryBot.define do
  factory :user do
    provider { "twitter" }
    uid { "test01234" }
    name { "test_user" }
    display_name { "Test User" }
    email { "user@test.com" }
    access_token { "testtest" }
  end
end
