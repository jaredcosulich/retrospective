module UserNamable
  attr_accessor :user_name
        
  private
  
  def set_user
    return if user_name.blank?    
    u = User.find_by_name(user_name)
    
    u = User.create(name: user_name) if u.nil?
    self.user = u  
  end
end