class Group < ApplicationRecord
  has_many :mentors, class_name: 'Person'
  has_many :mentees, class_name: 'Person'

  validates :mentors, presence: true, on: :create
end
