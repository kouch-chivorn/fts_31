class TestQuestion < ActiveRecord::Base
  belongs_to :test
  belongs_to :question
  belongs_to :answer
end
