class Person < ApplicationRecord
  has_secure_token :random_id
  has_secure_token :verification_token

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :about, presence: true

  ROLES= {
    1 => :mentee,
    2 => :mentor
  }

  def role_name
    ROLES[self.role]
  end

  def role_name=(r)
    if r.class == String
      r = r.to_sym
    end

    if r.class == Symbol
      r = ROLES.key(r)
    end

    if r
      self.role = r
    else
      self.role = 1
    end
  end

  def to_param
    random_id
  end

end
