class RemoveColumnFromEvent < ActiveRecord::Migration[8.1]
  def change
    remove_column :events, :acitivity_owner_id, :integer
  end
end
