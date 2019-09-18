FactoryBot.define do
  factory :contract do
    state { :under_contract }
    user { create :mentee }
    course
  end
end
