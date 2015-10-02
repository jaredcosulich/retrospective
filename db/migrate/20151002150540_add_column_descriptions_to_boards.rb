class AddColumnDescriptionsToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :good_column_description, :string
    add_column :boards, :meh_column_description, :string
    add_column :boards, :bad_column_description, :string
  end
end
