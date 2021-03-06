class AddUserToRestaurants < ActiveRecord::Migration[6.1]
  def change
    add_reference :restaurants, :user
  end
end
