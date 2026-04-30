class RemoveExtraColumnsFromEvents < ActiveRecord::Migration[8.1]
  def change
    rename_column :events, :date, :start_date
    remove_column :events, :start_time, :datetime
    remove_column :events, :end_time, :datetime
  end
end
