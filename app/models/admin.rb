class Admin < ActiveRecord::Base
  has_one :user, as: :system_user
  has_many :events

  accepts_nested_attributes_for :user
end
