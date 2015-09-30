class Board < ActiveRecord::Base
  has_many :items
  
  def names
    (items + items.map(&:votes) + items.map(&:comments)).flatten.map(&:user).uniq.compact.map(&:name)
  end  
end
