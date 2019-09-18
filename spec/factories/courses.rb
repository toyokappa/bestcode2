FactoryBot.define do
  factory :course do
    name { "Test Course" }
    description { "test test test test" }
    fee { 1000 }
    is_shot { false }
    has_stopped { false }
    plan
  end
end
