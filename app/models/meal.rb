class Meal < ApplicationRecord
  include PgSearch::Model

  belongs_to :restaurant
  has_many :line_items
  has_one_attached :photo

  validates_presence_of :name, :price

  monetize :price_cents
end
