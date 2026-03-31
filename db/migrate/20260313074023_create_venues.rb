class CreateVenues < ActiveRecord::Migration[8.1]
  def change
    create_table :venues do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.integer :capacity, null: false, default: 0
      t.timestamps
    end
  end
end
