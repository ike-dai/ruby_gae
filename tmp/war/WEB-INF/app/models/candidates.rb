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

class Candidates
  include Bumble
  ds :party_id, :year, :month, :day, :hour, :minutes, :point
  belongs_to :party, Parties
  has_many :participates, Participates, :candidate_id

  def count(participates)
    normal_count = 0
    high_count = 0
    p participates
    participates.each do |participate|
      if participate.participation == 1
        if weight = Weights.all({:user_id => participate.user_id, :party_id => self.party_id}).first.weight != 1
          high_count = high_count + 1
        else
          normal_count = normal_count + 1
        end
      end
    end
    normal = "参加者数：" + normal_count.to_s
    high = "重要参加者数：" + high_count.to_s
    all = "<font color='red' size='+2'>全参加者数：" + (normal_count+high_count).to_s + "</font>"
    return normal, high, all
  end

end
