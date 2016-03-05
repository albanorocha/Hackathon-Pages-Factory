class TeamUser < ActiveRecord::Base
  enum role: [:membro, :mentor]
  after_initialize :set_default_role, :if => :new_record?

  validates :user, :uniqueness => {:scope => :team_id}



  belongs_to :user
  belongs_to :team

  def set_default_role
    self.role ||= :membro
  end
end
