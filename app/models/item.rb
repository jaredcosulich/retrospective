require 'user_namable'
require 'sluggable'

class Item < ActiveRecord::Base
  belongs_to :board
  belongs_to :user
  has_many :comments
  has_many :votes
  
  scope :for_column, -> (column_name) { where("column_name = ?", column_name) }   
  scope :recent, -> { order(id: :desc) } 

  include UserNamable  
  before_create :set_user

  extend FriendlyId  
  friendly_id :slug, use: :slugged
  
  include Sluggable  
  after_create :generate_slug
  
  def votes_list
    votes.map(&:user).compact.map(&:name).compact.join(', ')
  end

end
