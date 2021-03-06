class RemoveOpeningDaysInRestaurants < ActiveRecord::Migration[6.1]
  def change
    remove_column :restaurants, :opening_days, :string, array: false
  end
end
