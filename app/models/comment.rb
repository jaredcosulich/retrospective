require 'user_namable'
require 'sluggable'

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :item, counter_cache: true, :touch => true
  
  scope :recent, -> { order(id: :desc) } 
  
  include UserNamable  
  before_create :set_user

  extend FriendlyId  
  friendly_id :slug, use: :slugged
  
  include Sluggable  
  after_create :generate_slug
  
end
