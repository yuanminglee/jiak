class ChangeColumnInRestaurants < ActiveRecord::Migration[6.1]
  def change
    change_column :restaurants, :opening_days, :string, array: false
  end
end
