require 'user_namable'

class Item < ActiveRecord::Base
  belongs_to :board
  belongs_to :user
  has_many :comments
  has_many :votes
  
  scope :for_column, -> (column_name) { where("column_name = ?", column_name) } 

  include UserNamable  
  before_create :set_user
  
  
  def votes_list
    votes.map(&:user).compact.map(&:name).compact.join(', ')
  end

end
