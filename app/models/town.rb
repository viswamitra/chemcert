class Town < ActiveRecord::Base
  has_many :location_relations
  has_many :postal_codes, :through => :location_relations
  has_many :state, :through => :location_relations
end
