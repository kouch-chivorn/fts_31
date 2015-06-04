class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :test_questions, dependent: :destroy

  validates_presence_of :content, length: {maximum:100}

  scope :correct, ->{where correct: true}
end
