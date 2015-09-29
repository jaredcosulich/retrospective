class AddTitleToItems < ActiveRecord::Migration
  def change
    remove_column :items, :description
    add_column :items, :title, :string
  end
end
