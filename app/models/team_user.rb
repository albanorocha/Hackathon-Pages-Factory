class TeamUser < ActiveRecord::Base
  enum role: [:leader, :member, :mentor]
  after_initialize :set_default_role, :if => :new_record?

  belongs_to :user
  belongs_to :team

  def set_default_role
    self.role ||= :member
  end
end
