class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :state, null: false, default: 0

      t.timestamps
    end
  end
end
