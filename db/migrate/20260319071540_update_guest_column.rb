class UpdateGuestColumn < ActiveRecord::Migration[8.1]
  def change
  rename_column :guests, :user_id_id, :user_id
  remove_column :guests, :rsvp_status, :string
  add_column :guests, :email, :string
  end
end
