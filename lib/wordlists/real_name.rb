dir = File.dirname(__FILE__)
require dir + '/female_names'
require dir + '/male_names'

class RealName
  
  def self.first_name(gender=nil)
    case gender.to_s
    when /^male/i
      self.random_male_first_name
    when /^female/i
      self.random_female_first_name
    else
      self.send("random_#{['male', 'female'][rand(2)]}_first_name")
    end
  end
  
end