class CreateMeals < ActiveRecord::Migration[6.1]
  def change
    create_table :meals do |t|
      t.string :name
      t.text :description
      t.text :ingredients
      t.integer :price
      t.integer :pax
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
