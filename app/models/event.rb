class Event < ActiveRecord::Base
  has_many :event_users
  has_many :users, :through => :event_users
  has_many :teams
  has_many :projects, through: :teams

  has_one :image, :as => :imageable, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, :if => lambda{ |obj| obj.address_changed? }


  accepts_nested_attributes_for :image, :reject_if => :all_blank

  def create_image
    default_image = self.build_image
    File.open('./public/projects/bg1.jpg') do |f|
      default_image.image = f
    end
  end

  def to_param
    "#{code}".parameterize
  end

end
