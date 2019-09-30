class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.boolean :is_already_read, null: false, default: false
      t.integer :sender_id, null: false, index: true
      t.integer :receiver_id, null: false, index: true

      t.timestamps
    end
  end
end
