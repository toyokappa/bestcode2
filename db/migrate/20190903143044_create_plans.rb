class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.string :name, null: false, default: ""
      t.text :description
      t.integer :state, null: false, default: 0
      t.references :user

      t.timestamps
    end
  end
end
