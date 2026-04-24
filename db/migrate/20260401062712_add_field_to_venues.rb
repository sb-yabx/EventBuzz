class AddFieldToVenues < ActiveRecord::Migration[8.1]
  def change
    add_column :venues, :facilities, :string
    add_column :venues, :contact, :integer
    add_column :venues, :status, :string
  end
end
