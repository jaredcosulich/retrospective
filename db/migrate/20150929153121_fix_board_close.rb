class FixBoardClose < ActiveRecord::Migration
  def change
    
    remove_column :boards, :col-sm-m
    add_column :boards, :close_at, :datetime
    
  end
end
