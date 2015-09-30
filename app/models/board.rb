require 'sluggable'

class Board < ActiveRecord::Base
  has_many :items
  
  extend FriendlyId  
  friendly_id :slug, use: :slugged
  
  include Sluggable  
  after_create :generate_slug
  
  
  def names
    (items + items.map(&:votes) + items.map(&:comments)).flatten.map(&:user).uniq.compact.map(&:name)
  end  
end
