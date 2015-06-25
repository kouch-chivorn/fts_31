FactoryGirl.define do
  factory :question do
    content
    category
  end

  factory :category_with_questions do
    transient do
      questions_count 20
    end

    after(:create) do |category, evaluator|
      create_list(:question, evaluator.questions_count,
                  content: Faker::Lorem.sentence, category: category)
    end
  end

end
