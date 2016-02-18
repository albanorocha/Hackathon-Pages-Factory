class EventUser < ActiveRecord::Base
  enum role: [:medhacker, :manager, :mentor]
  after_initialize :set_default_role, :if => :new_record?

  belongs_to :user
  belongs_to :event

  def set_default_role
    self.role ||= :medhacker
  end

end
