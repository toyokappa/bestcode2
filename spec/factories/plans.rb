FactoryBot.define do
  factory :plan do
    name { "Test Plan" }
    description { "This is test plan" }
    state { 1 }
    user
  end
end
