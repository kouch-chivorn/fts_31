class Category < ActiveRecord::Base
  has_many :questions
  has_many :tests, dependent: :destroy
  accepts_nested_attributes_for :tests
  
  validates_presence_of :name
  validates_presence_of :description, length: {mininum: 30}
  validates_uniqueness_of :name
end
