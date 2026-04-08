class CreateQueryMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :query_messages do |t|
      t.references :query, null: false, foreign_key: true
      t.text :message
      t.string :sender_type
      t.timestamps
    end
  end
end
