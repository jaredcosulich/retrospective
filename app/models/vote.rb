require 'user_namable'
require 'sluggable'

class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  
  scope :recent, -> { order(id: :desc) } 

  include UserNamable  
  before_create :set_user
  
  extend FriendlyId  
  friendly_id :slug, use: :slugged
  
  include Sluggable  
  after_create :generate_slug
  
end
