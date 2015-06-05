class Question < ActiveRecord::Base
  belongs_to :category
  has_many :answers
  has_many :test_questions
  validate :check_answer

  accepts_nested_attributes_for :answers, allow_destroy: true, 
                                reject_if: :all_blank

  validates :category_id, presence: true
  validates :content, presence: true, length: {maximum: 100}

  private
  def check_answer
    if answers.select{|a| a.correct}.blank?
      errors.add :base, t "question.model."
    end
  end
end
