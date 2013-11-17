class State < ActiveRecord::Base

  attr_accessible :name
  has_many :location_relations
  has_many :cities, :through => :location_relations
  has_many :postal_codes, :through => :location_relations

  validates :name, :uniqueness => true, :presence => true

end
