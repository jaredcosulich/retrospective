require 'sluggable'

class Board < ActiveRecord::Base
  belongs_to :group
  has_many :items
  
  extend FriendlyId  
  friendly_id :slug, use: :slugged
  
  include Sluggable  
  after_create :generate_slug
  
  attr_accessor :duration
  
  before_save :set_close_at
  
  def names
    (items + items.map(&:votes) + items.map(&:comments)).flatten.map(&:user).uniq.compact.map(&:name)
  end  
  
  def self.generate_password
    chars = %w(2 3 4 5 6 7 8 9 B C D F G H J K M N P Q R S T V W X Y Z b c d f g h j k m n p q r s t)
    (1..12).collect { chars[rand(chars.length)]}.join 
  end
  
  private
  def set_close_at
    return unless duration.present?
    self.close_at = duration.to_i.hours.from_now
  end
end
