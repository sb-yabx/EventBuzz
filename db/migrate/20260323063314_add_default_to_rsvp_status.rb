class AddDefaultToRsvpStatus < ActiveRecord::Migration[8.1]
  def change
     change_column_default :rsvps, :status, "Pending"
  end
end
