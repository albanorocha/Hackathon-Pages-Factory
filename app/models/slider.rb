class Slider < ActiveRecord::Base
  belongs_to :sliderable, :polymorphic => true

  has_one :image, :as => :imageable, dependent: :destroy

  accepts_nested_attributes_for :image
end
