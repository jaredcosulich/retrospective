module UserNamable
  attr_accessor :user_name
        
  private
  
  def set_user
    u = User.find_by_name(user_name)
    
    u = User.create(name: user_name) if u.nil?
  
    self.user = u  
  end
end