class RemoveColumnsGuest < ActiveRecord::Migration[8.1]
  def change
    remove_column :guests, :name, :string
  end
end
