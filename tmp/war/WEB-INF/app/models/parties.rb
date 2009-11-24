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

class Parties
  include Bumble
  ds :name, :place
  has_many :weights, Weights, :party_id
  has_many :candidates, Candidates, :party_id
  
  require 'net/http'
  Net::HTTP.version_1_2

#  def get_point
#    api_method_name = "?q=" + self.place
#    p api_method_name
#    response = nil
#    http = Net::HTTP.new("www.geocoding.jp",80)
#    p http.start
#    Net::HTTP.start("www.geocoding.jp", 80) {|http|
 #     p http
  #  }
      #      response = http.get(api_method_name)
#      p response.body
#    }

 # end

end
