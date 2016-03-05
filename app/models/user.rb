class User < ActiveRecord::Base
  enum role: [:user, :manager, :admin]
  after_initialize :set_default_role, :if => :new_record?

  validates :name, presence: true

  has_many :event_users
  has_many :events, :through => :event_users

  has_many :team_users
  has_many :teams, :through => :team_users

  def set_default_role
    self.role ||= :user
  end

  def is_the_role? my_role
    self.role == my_role.to_s
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable, :confirmable, :recoverable
  devise :database_authenticatable, :rememberable, :trackable,
    :validatable, :registerable
end
