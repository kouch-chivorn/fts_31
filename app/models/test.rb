class Test < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :test_questions, dependent: :destroy
end
