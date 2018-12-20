class Person < ApplicationRecord
  has_secure_password validations: false
	attr_accessor :password_confirmation

  has_secure_token :random_id
  has_secure_token :verification_token

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  belongs_to :group, required: false

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :about, presence: true
  validates :password, length: { in: 14..72 }, if: Proc.new { |p| p.role == 3 && p.password != nil }
  validates :password, confirmation: true, if: Proc.new { |p| p.role == 3 }
  validates :password_confirmation, presence: true, unless: Proc.new { |p| p.password.blank? }

  before_save :align_group_state

  ROLES = {
    1 => :mentee,
    2 => :mentor,
    3 => :godmother
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

  def self.tagged_with(name)
    Tag.find_by_name!(name).people
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
    joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip.downcase).first_or_create!
    end
  end

  def align_group_state
    unless self.state_name == :done
      if self.state_name == :in_group && self.group.blank?
        self.state_name = :okay
      elsif self.state_name != :in_group && self.group
        self.state_name = :in_group
      end
    end

  end

end
