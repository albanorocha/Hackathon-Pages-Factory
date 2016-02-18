class Event < ActiveRecord::Base
  has_many :event_users
  has_many :users, :through => :event_users
  has_many :teams
  has_many :projects, through: :teams

  def to_param
    "#{code}".parameterize
  end

end
