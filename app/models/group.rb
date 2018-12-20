class Group < ApplicationRecord
  has_many :mentors, class_name: 'Person'
  has_many :mentees, class_name: 'Person'

  validates :mentors, presence: true, on: :create

  def mentors
    Person.where(group_id: self.id).where(role: 2)
  end

  def mentor_ids
    self.mentors.map { |m| m.id }
  end

  def mentees
    Person.where(group_id: self.id).where(role: 1)
  end

  def mentee_ids
    self.mentees.map { |m| m.id }
  end
end
