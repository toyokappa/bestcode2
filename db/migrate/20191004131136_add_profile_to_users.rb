class AddProfileToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.text :introduction
      t.string :url
    end
  end
end
