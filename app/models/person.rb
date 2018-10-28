class Person < ApplicationRecord
  has_secure_token :random_id
  has_secure_token :verification_token

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :about, presence: true

  def to_param
    random_id
  end
end
