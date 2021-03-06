class Order < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :meals, through: :line_items
  has_many :line_items, dependent: :destroy

  def calculate_total_price
    line_items.sum do |line_item|
      line_item.quantity * line_item.meal.price
    end
  end

  def update_total_price
    update(total_price: calculate_total_price)
  end
end
