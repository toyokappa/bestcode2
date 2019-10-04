FactoryBot.define do
  factory :user do
    provider { "github" }
    uid { Faker::Number.number digits: 13 }
    name { Faker::Internet.username separators: %w[_ -] }
    display_name { Faker::Name.name }
    email { Faker::Internet.safe_email }
    image { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "images", "user.jpg"), "jpg") }
    access_token { Faker::Internet.device_token }
  end
end
