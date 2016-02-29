class Team < ActiveRecord::Base
  has_many :team_users, dependent: :destroy
  has_many :users, :through => :team_users
  has_many :projects, dependent: :destroy

  belongs_to :event

  def is_the_user_there? user
    !self.users.where(id: user).empty?
  end

end
