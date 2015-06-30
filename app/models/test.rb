class Test < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :test_questions, dependent: :destroy

  validates_presence_of :user_id
  validates_presence_of :category_id
  before_create :create_questions
  before_update :update_result
  accepts_nested_attributes_for :test_questions, allow_destroy: true

  def time_out?
    if started_time
      Time.zone.now > started_time + self.category.duration.minutes
    end
  end

  private
  def create_questions
    questions= self.category.questions.random_questions
    questions.each{|q| self.test_questions.build question: q}
  end

  def update_result
    points = test_questions.select do |test_question|
      test_question.answer && test_question.answer.correct
    end.count
    self.result = points
  end
end
