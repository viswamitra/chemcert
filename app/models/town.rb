class Town < ActiveRecord::Base
  has_many :location_relations
end
