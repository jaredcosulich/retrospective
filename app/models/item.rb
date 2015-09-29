class Item < ActiveRecord::Base
  belongs_to :board
  belongs_to :user
  has_many :comments
  has_many :votes
  
  scope :for_column, -> (column_name) { where("column_name = ?", column_name) } 

end
