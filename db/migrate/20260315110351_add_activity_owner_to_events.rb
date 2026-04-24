class AddActivityOwnerToEvents < ActiveRecord::Migration[8.1]
  def change
    add_reference :events, :acitivity_owner, foreign_key: { to_table: :users }, index: true
  end
end
