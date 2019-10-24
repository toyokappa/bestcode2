FactoryBot.define do
  factory :resume do
    description { Faker::Lorem.paragraph }
    user
  end
end
