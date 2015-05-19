class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :body, null: false
      t.string :visibility, null: false

      t.timestamps null: false
    end
    add_index :goals, :user_id
    add_index :goals, :title
  end
end
