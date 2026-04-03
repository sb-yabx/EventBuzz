class AddCapacityToEvent < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :capacity, :integer
  end
end
