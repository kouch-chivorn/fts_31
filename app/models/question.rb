class Question < ActiveRecord::Base
  belongs_to :category
  has_many :answers
  has_many :test_questions
  before_create :check_answer

  accepts_nested_attributes_for :answers, allow_destroy: true, 
                                reject_if: :all_blank

  validates :category_id, presence: true
  validates :content, presence: true, 
    length: {maximum: Settings.question.content_length}

  scope :random_questions, -> {limit(Settings.test_quest.num).order("RANDOM()")}

  private
  def check_answer
    unless answers.any?(&:correct?)
      errors.add :base, Settings.model.question.choose_one
    end
  end
end
