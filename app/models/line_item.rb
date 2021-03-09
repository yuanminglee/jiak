class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :meal
  after_save :update_order_price

  private

  def update_order_price
    order.update_total_price
  end
end
