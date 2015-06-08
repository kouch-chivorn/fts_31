FactoryGirl.define do
  factory :category do
    name          "JAVA"
    description   {Faker::Lorem.paragraph}
    duration      20
  end
end