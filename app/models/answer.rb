class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :test_questions
  
  validates_presence_of :content
end
