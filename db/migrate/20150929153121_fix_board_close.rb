class FixBoardClose < ActiveRecord::Migration
  def change
    
    remove_column :boards, :close_date
    add_column :boards, :close_at, :datetime
    
  end
end
