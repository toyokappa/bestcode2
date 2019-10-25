FactoryBot.define do
  factory :skill do
    name { "Rails" }
    level { 1 }
    experience { 1 }
    user
  end
end
