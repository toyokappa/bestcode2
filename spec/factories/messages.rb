FactoryBot.define do
  factory :message do
    body { Faker::Lorem.paragraph }
    is_already_read { false }
    sender { create :user }
    receiver { create :user }
  end
end
