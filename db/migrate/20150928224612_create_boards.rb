class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :good_column_name
      t.string :bad_column_name
      t.string :meh_column_name
      t.time :xxx

      t.timestamps null: false
    end
  end
end
