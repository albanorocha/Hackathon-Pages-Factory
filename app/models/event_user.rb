class EventUser < ActiveRecord::Base
  enum role: [:medhacker, :organizador]
  after_initialize :set_default_role, :if => :new_record?

  validates :user, :uniqueness => {:scope => :event_id}

  belongs_to :user
  belongs_to :event

  def set_default_role
    self.role ||= :medhacker
  end

end
