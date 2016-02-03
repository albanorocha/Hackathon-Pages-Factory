class Maker < ActiveRecord::Base
  has_one :user, as: :system_user
end
