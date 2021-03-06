class Order < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :meals, through: :line_items
  has_many :line_items, dependent: :destroy
end
