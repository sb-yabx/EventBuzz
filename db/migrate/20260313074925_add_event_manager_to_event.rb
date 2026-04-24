class AddEventManagerToEvent < ActiveRecord::Migration[8.1]
  def change
    add_reference :events, :event_manager, foreign_key: { to_table: :users }, index: true
  end
end
