class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name, null: false, default: ""
      t.text :description
      t.integer :fee
      t.boolean :is_shot
      t.boolean :has_stopped
      t.references :plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
