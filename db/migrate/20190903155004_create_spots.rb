class CreateSpots < ActiveRecord::Migration[6.0]
  def change
    create_table :spots do |t|
      t.string :name, null: false, default: ""
      t.text :description
      t.string :address
      t.decimal :latitude, precision: 11, scale: 8
      t.decimal :longitude, precision: 11, scale: 8
      t.integer :review
      t.integer :position
      t.references :plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
