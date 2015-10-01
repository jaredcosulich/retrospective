class Group < ActiveRecord::Base
  
  has_many :boards
  belongs_to :parent_group, class_name: 'Group'
  has_many :children, class_name: 'Group', foreign_key: 'parent_group_id'

  extend FriendlyId  
  friendly_id :title, use: :slugged

  attr_accessor :child_group_id
  after_create :associate_child
  
  private
  
  def associate_child
    return unless child_group_id
    child_group = Group.find_by_id(child_group_id)
    child_group.update_attributes(parent_group_id: id) unless child_group.nil?
  end

end
