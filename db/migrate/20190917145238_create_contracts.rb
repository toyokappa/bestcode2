class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.integer :user_id, null: false
      t.integer :course_id, null: false
      t.integer :state, null: false, default: 0

      t.timestamps
    end
  end
end
