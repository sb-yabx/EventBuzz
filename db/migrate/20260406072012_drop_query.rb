class DropQuery < ActiveRecord::Migration[8.1]
  def change
    drop_table :queries
  end
end
