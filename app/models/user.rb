class User < ActiveRecord::Base
  enum role: [:user, :manager, :admin]
  after_initialize :set_default_role, :if => :new_record?


  has_many :event_users
  has_many :events, :through => :event_users

  has_many :team_users
  has_many :teams, :through => :team_users

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable, :confirmable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
    :validatable, :registerable
end
