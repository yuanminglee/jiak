class Order < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :meals, through: :line_items
  has_many :line_items, dependent: :destroy

  monetize :total_price_cents

  def calculate_total_price
    line_items.sum do |line_item|
      line_item.quantity * line_item.meal.price
    end
  end

  def update_total_price
    update(total_price: Money.new(calculate_total_price))
  end

  def grouped_line_items
    line_items.group_by(&:meal).map do |meal, line_items|
      {
        name: meal.name,
        quantity: line_items.sum(&:quantity),
        line_amount: meal.price_cents * line_items.sum(&:quantity)
      }
    end
  end
end
