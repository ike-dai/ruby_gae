# ref. http://github.com/olabini/bumble/blob/96bdfc02b8bfc159c55035fbbbfb5b12536dd367/bumble/bumble.rb
# 
# InstanceMethods:
# - key
# - to_param
# - save!
# - delete!
#
# ClassMethods:
# - get(key)
# - delete(key)
# - find(condition)
# - create(attrs)
# - all(conditions, options)
#
# Define Relationship:
# - belongs_to
# - has_many

class Participates
  include Bumble
  ds :user_id, :candidate_id, :participation
  belongs_to :user, Users
  belongs_to :candidate, Candidates

  def get_name
    #user = Users.get(self.user_id)
#    user = Users.all({:id => self.user_id})
   # user = Users.get(self.user_id.to_s)
#    user = Users.get("10")
    #user = Users.get(self.user_id)
  #  user = Users.get(user.key)
#    te = Users.get(user.key)
    user_name = nil
    Users.all().each do |user|
      if user.key == self.user_id
        user_name = user.name
      end
    end
    #p Users.get(:id=>"10")
    #user = self.users
    #p user.key
    #p self.user_id
    #p self.key
    #p self.to_param
    #    user = Users.get(9)
#    p Users.get(self.user_id)
#    p user
#    p Users.all({:user_id => 9})
#    p Users.all({:id => 9})
#    p Users.all({:users_id => 9})
   # p Users.get("9")
#    p Users.all
    #p "test"
   # p Users.get(9)
    #  p 1
  #  p #user
  #  p 2
  #  p self.user_id
  #  p 3
  #  p self.candidate_id
  #  p 4
  #  p Users.all
    user_name
  end
  
  def yes_or_no
    if self.participation == 0
      "-"
    elsif self.participation == 1
      "<font color='red' size='+2'>OK</font>"
    else
      "<font color='blue' size='+2'>NG</font>"
    end
  end
  
  def ok_count participates
    normal_count = 0
    high_count = 0
    participates.each do |participate|
      if participate.participation == 1
        if weight = Weights.all({:user_id => participate.user_id, :party_id => Candidates.get(participate.candidate_id).first.party_id}).weight != 1
          high_count = high_count + 1
        else
          normal_count = normal_count + 1
        end
      end
    end
      normal = "参加者数：" + normal_count.to_s
      high = "重要参加者数：" + high_count.to_s
    return normal, high
  end
end
