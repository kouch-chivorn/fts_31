FactoryGirl.create :admin
FactoryGirl.create_list :user, 20
FactoryGirl.create :category
FactoryGirl.create :category, name: "PHP"
FactoryGirl.create :category, name: "Ruby"
FactoryGirl.create :category, name: "SQL"

# create question
categories = Category.all

categories.each do |category|
  20.times do
    question = category.questions.create! content: Faker::Lorem.sentence
    correct_ans = Random.rand(1...5)
    4.times do |n|
      question.answers.create content: Faker::Lorem.sentence, correct: (n+1) == correct_ans
    end
  end
end


