FactoryBot.define do
  factory :user do
    provider { "github" }
    uid { "test01234" }
    name { "test_user" }
    display_name { "Test User" }
    email { "user@test.com" }
    access_token { "testtest" }
  end

  factory :menter, class: User do
    provider { "github" }
    uid { "menter01234" }
    name { "test_menter" }
    display_name { "Test Menter" }
    email { "menter@test.com" }
    access_token { "testtest" }
  end

  factory :mentee, class: User do
    provider { "github" }
    uid { "mentee01234" }
    name { "test_mentee" }
    display_name { "Test Mentee" }
    email { "mentee@test.com" }
    access_token { "testtest" }
  end
end
