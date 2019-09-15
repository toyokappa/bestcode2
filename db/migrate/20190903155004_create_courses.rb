class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name, null: false, default: ""
      t.text :description
      t.integer :fee, null: false, default: 0
      t.boolean :is_shot, null: false, default: false
      t.boolean :has_stopped, null: false, default: false
      t.references :plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
