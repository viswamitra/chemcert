class State < ActiveRecord::Base
  has_many :location_relations
  has_many :cities, :through => :location_relations
  has_many :postal_codes, :through => :location_relations
end
