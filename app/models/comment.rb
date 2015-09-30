require 'user_namable'

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  
  scope :recent, -> { order(id: :desc) } 
  
  include UserNamable  
  before_create :set_user
  
end
