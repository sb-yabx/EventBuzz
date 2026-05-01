class AddIndexesInTables < ActiveRecord::Migration[8.1]
  def change
  add_index :events, :start_date
  add_index :rsvps, [ :event_id, :status ]
  add_index :rsvps, [ :user_id, :event_id ]

  add_index :users, :role

  add_index :query_messages, [ :query_id, :created_at ]

  add_index :activities, [ :event_id, :duration ]
  end
end
