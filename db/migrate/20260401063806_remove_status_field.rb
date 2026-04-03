class RemoveStatusField < ActiveRecord::Migration[8.1]
  def change
    remove_column :venues, :status, :integer
  end
end
