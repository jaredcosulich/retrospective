module Sluggable

  private

    def generate_slug
      chars = %w(2 3 4 5 6 7 8 9 B C D F G H J K M N P Q R S T V W X Y Z b c d f g h j k m n p q r s t)
      id_slug = "#{self.id}#{rand(10)}#{rand(10)}}".to_i
    
      slugified = id_slug.to_s(2).reverse.scan(/.{1,5}/).map do |bits|
        chars[bits.reverse.to_i(2)]
      end.reverse.join
    
      self.update_attribute(:slug, "#{chars[rand(35) + 8]}#{slugified}#{chars[rand(35) + 8]}")
    end    
  
end