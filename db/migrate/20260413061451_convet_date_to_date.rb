class ConvetDateToDate < ActiveRecord::Migration[8.1]
  def change
    rename_column :events, :start_date, :date
  end
end
