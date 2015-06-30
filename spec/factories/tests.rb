FactoryGirl.define do
  factory :test do
    user      {FactoryGirl.create :user}
    category  {FactoryGirl.create :category}
  end
end
