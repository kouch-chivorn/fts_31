class Category < ActiveRecord::Base
  has_many :questions
  has_many :tests, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name
end
