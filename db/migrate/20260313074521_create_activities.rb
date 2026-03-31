class CreateActivities < ActiveRecord::Migration[8.1]
  def change
    create_table :activities do |t|
      t.string :activity_name, null: false
      t.text :activity_description, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
