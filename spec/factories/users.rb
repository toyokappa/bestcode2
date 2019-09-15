FactoryBot.define do
  factory :user do
    provider { "github" }
    uid { "test01234" }
    name { "test_user" }
    display_name { "Test User" }
    email { "user@test.com" }
    access_token { "testtest" }
  end
end
