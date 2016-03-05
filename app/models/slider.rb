class Slider < ActiveRecord::Base
  belongs_to :sliderable, :polymorphic => true

  has_one :image, :as => :imageable, dependent: :destroy

  validates :title, presence: true
  validates :description, length: { maximum: 300 }

  accepts_nested_attributes_for :image
end
