class AddOpeningDaysInRestaurants < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :opening_days, :string
  end
end
