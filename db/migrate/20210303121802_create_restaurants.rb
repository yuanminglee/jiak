class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :description
      t.text :address
      t.time :collection_time
      t.string :opening_days, array: true

      t.timestamps
    end
  end
end
