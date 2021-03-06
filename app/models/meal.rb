class Meal < ApplicationRecord
  belongs_to :restaurant
  has_many :line_items

  has_one_attached :photo

  monetize :price_cents
end
