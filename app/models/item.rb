require 'user_namable'
require 'sluggable'

class Item < ActiveRecord::Base
  belongs_to :board
  belongs_to :user
  has_many :comments
  has_many :votes
  
  scope :for_column, -> (column_name) { where("column_name = ?", column_name.downcase) }   
  scope :recent, -> { order(id: :desc) } 
  
  validates_presence_of :title

  include UserNamable  
  before_create :set_user

  extend FriendlyId  
  friendly_id :slug, use: :slugged
  
  include Sluggable  
  after_create :generate_slug
  
  attr_accessor :comment
  after_create :create_comment
  
  before_save :downcase_column_name
  
  def votes_list
    votes.map(&:user).compact.map(&:name).compact.join(', ')
  end

  private
  
  def create_comment
    return unless comment.present?
    self.comments.create(comment: comment, user: user)
  end
  
  def downcase_column_name
    self.column_name = column_name.downcase
  end
end
