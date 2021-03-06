class RemoveOpeningDaysInRestaurant < ActiveRecord::Migration[6.1]
  def change
    remove_column :restaurants, :opening_days, :string
  end
end
