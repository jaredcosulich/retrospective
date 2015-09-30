class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  
  scope :recent, -> { order(id: :desc) } 
  
end
