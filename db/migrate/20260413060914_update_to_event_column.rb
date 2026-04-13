class UpdateToEventColumn < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :end_date, :date
    rename_column :events , :date , :start_date
  end
end
