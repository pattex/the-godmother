class Person < ApplicationRecord
  has_secure_token :random_id
  has_secure_token :verification_token

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :about, presence: true

  ROLES = {
    1 => :mentee,
    2 => :mentor
  }

  STATES = {
    1 => :unverified,
    2 => :verified,
    3 => :okay,
    4 => :waiting,
    5 => :in_group,
    23 => :declined,
    42 => :done
  }

  def role_name
    ROLES[self.role]
  end

  def role_name=(r)
    r = ROLES.key(r.to_sym)

    if r
      self.role = r
    else
      self.role = 1
    end
  end

  def state_name
    STATES[self.state]
  end

  def state_name=(s)
    s = STATES.key(s.to_sym)

    if s
      self.state = s
    else
      self.state = 1
    end
  end

  def to_param
    random_id
  end

end
