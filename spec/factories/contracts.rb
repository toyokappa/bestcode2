FactoryBot.define do
  factory :contract do
    state { :under_contract }
    user
    course
  end
end
