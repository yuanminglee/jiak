class ChangeOpeningDaysToArray < ActiveRecord::Migration[6.1]
  def change
    change_column :restaurants, :opening_days, "varchar[] USING (string_to_array(opening_days, ','))"
  end
end
