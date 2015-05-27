class Question < ActiveRecord::Base
  belongs_to :category
  has_many :answers
  has_many :test_questions

  accepts_nested_attributes_for :word_answers
  
  validates :category_id, presence: true
  validates :content, presence: true, length: {maximum: 100}
end

