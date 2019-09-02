class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :provider, null: false, default: ""
      t.string :uid, null: false, default: ""
      t.string :name, null: false, default: "", index: { unique: true }
      t.string :display_name
      t.string :email
      t.string :access_token
      t.string :image

      t.timestamps
    end
    add_index :users, [:provider, :uid], unique: true
  end
end
