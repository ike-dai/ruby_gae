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
end
