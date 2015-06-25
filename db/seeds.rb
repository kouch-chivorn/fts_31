FactoryGirl.create :admin
FactoryGirl.create_list :user, 20
FactoryGirl.create :category
FactoryGirl.create :category, name: "PHP"
FactoryGirl.create :category, name: "Ruby"
FactoryGirl.create :category, name: "SQL"

#create test questions
