class AddAmountToOrder < ActiveRecord::Migration[6.1]
  def change
    add_monetize  :orders, :total_price, currency: { present: false }
  end
end
