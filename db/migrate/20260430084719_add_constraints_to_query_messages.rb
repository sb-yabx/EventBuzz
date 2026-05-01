class AddConstraintsToQueryMessages < ActiveRecord::Migration[8.1]
  def change
    change_column_null :query_messages, :message, false
  end
end
