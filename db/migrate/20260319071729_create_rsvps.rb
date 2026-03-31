class CreateRsvps < ActiveRecord::Migration[8.1]
  def change
    create_table :rsvps do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.string :status
      t.text :special_request

      
      t.string :dietary_preference
      t.string :seating_preference
      t.boolean :need_parking
      t.boolean :need_accommodation

      t.timestamps
    end
  end
end

