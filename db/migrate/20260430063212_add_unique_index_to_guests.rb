class AddUniqueIndexToGuests < ActiveRecord::Migration[8.1]
  def change
    add_index :guests, [:event_id, :email], unique: true
    change_column_null :guests, :email, false
  end
end
