class AddPasswordToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :password, :string
    add_column :boards, :slug, :string
    add_column :items, :slug, :string
    add_column :comments, :slug, :string
    add_column :votes, :slug, :string
    
    add_index :boards, :slug
    add_index :items, :slug
    add_index :votes, :slug
    add_index :comments, :slug
  end
end
