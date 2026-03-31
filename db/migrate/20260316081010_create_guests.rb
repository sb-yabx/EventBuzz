class CreateGuests < ActiveRecord::Migration[8.1]
  def change
    create_table :guests do |t|
      t.string :name, null: false
      t.string :rsvp_status, null: false
      t.references :event, foreign_key: true, null: false
      t.timestamps
    end
  end
end
