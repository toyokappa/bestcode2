class CreateResumes < ActiveRecord::Migration[6.0]
  def change
    create_table :resumes do |t|
      t.text :description
      t.integer :start_year
      t.integer :start_month
      t.integer :end_year
      t.integer :end_month
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
