class Event < ActiveRecord::Base
  has_many :event_users, dependent: :destroy
  has_many :users, :through => :event_users
  has_many :teams, dependent: :destroy
  has_many :projects, through: :teams

  has_one :image, :as => :imageable, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, :if => lambda{ |obj| obj.address_changed? }

  validates :name, :date, :address, :description, presence: true


  accepts_nested_attributes_for :image, :reject_if => :all_blank

  def create_image
    default_image = self.build_image
    File.open('./public/projects/bg1.jpg') do |f|
      default_image.image = f
    end
  end

  def self.events_markers
    events = Event.all

    markers = ""

    events.each do |event|
      markers+="&markers=#{event.latitude}%2C#{event.longitude}"
    end
    markers
  end

  def to_param
    "#{code}".parameterize
  end

  def is_the_user? user, role
    !self.event_users.where(user_id: user, role: EventUser.roles[role]).empty?
  end

  def there_is_the_user? user
    self.is_the_user? user, :organizador or
    self.is_the_user? user, :medhacker
  end


  def self.create_code
    if Event.all.empty?
      number = sprintf '%05d', 1
    else
      number = sprintf '%05d', (Event.last.code[3..7].to_i + 1)
    end

    "MH-" + number
  end

  def only_one_organizer?
    self.event_users.where(role: EventUser.roles[:organizador]).count == 1
  end
end
