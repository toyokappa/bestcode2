FactoryBot.define do
  factory :plan do
    name { "Test Plan" }
    description { "test test test test" }
    state { 1 }
    user { create :mentor }
  end
end
