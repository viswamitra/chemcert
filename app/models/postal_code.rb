class PostalCode < ActiveRecord::Base

  attr_accessible :code
  has_many :location_relations
  has_many :towns, :through => :location_relations
  has_many :states, :through => :location_relations

  validates :code, :uniqueness => true, :presence => true


end
