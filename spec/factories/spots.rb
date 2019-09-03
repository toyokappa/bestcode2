FactoryBot.define do
  factory :spot do
    name { "MyString" }
    description { "MyText" }
    address { "MyString" }
    latitude { "9.99" }
    longitude { "9.99" }
    review { 1 }
    position { 1 }
    plan { nil }
  end
end
