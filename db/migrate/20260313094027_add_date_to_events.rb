class AddDateToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :date , :datetime
  end
end
