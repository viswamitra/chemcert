class PostalCode < ActiveRecord::Base
  has_many :location_relations
  has_many :towns, :through => :location_relations
  has_many :states, :through => :location_relations

end
