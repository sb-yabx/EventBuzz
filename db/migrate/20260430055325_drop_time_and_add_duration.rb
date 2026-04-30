class DropTimeAndAddDuration < ActiveRecord::Migration[8.1]
  def change
    remove_column :activities, :start_time, :datetime
    remove_column :activities, :end_time, :datetime
    add_column :activities, :duration, :integer
  end
end
