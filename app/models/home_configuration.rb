class HomeConfiguration < ActiveRecord::Base
  has_many :sliders, -> { order 'created_at asc' }, :as => :sliderable

  accepts_nested_attributes_for :sliders
end
