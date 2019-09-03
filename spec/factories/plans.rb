FactoryBot.define do
  factory :plan do
    name { "MyString" }
    description { "MyText" }
    state { 1 }
    references { "" }
  end
end
