class ChangeDefaultOnUser < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :is_chef, false
  end
end
