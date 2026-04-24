class AddUserIdToGuests < ActiveRecord::Migration[8.1]
  def change
    add_reference :guests, :user_id, foreign_key: { to_table: :users }, index: true
  end
end
