class AddGuestCountToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :guests_count, :integer
  end
end
