class AddGroupToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :group_id, :integer
  end
end
