class AddNullConstraintToEventsDate < ActiveRecord::Migration[8.1]
  def change
    change_column_null :events, :start_date, false
    change_column_null :events, :capacity, false
  end
end
