FactoryBot.define do
  factory :course do
    name { "MyString" }
    description { "MyText" }
    fee { 0 }
    is_shot { false }
    has_stopped { false }
    plan { nil }
  end
end
