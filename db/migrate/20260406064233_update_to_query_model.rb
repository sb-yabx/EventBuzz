class UpdateToQueryModel < ActiveRecord::Migration[8.1]
  def change
    add_column :queries, :reply, :text
    remove_column :queries, :email , :string
    remove_column :queries, :name , :string
  end
end
