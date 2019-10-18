FactoryBot.define do
  factory :course do
    name { "Test Course" }
    description { "This is test course" }
    fee { 1000 }
    is_shot { false }
    has_stopped { false }
    plan
  end
end
