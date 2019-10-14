FactoryBot.define do
  factory :plan do
    name { "Test Plan" }
    description { "test test test test" }
    state { 1 }
    user

    # NOTE: Planへcoursesの必須バリデーションを追加した際に
    #       テストが通らなくなったので、下記の対応を追加。
    #       この方法で良いかは不明なので、どこかのタイミングで
    #       ベストプラクティスは探すほうが良さそう。
    with_default_course

    trait :with_default_course do
      after(:build) do |plan|
        plan.courses << build(:course, plan: plan)
      end
    end

    trait :with_no_courses do
      after(:build) do |plan|
        plan.courses = []
      end
    end
  end
end
