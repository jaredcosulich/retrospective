class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.string :column_name
      t.integer :board_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
