class Town < ActiveRecord::Base

  attr_accessible :name
  has_many :location_relations
  has_many :postal_codes, :through => :location_relations
  has_many :state, :through => :location_relations

  validates :name, :uniqueness => true, :presence => true



  scope :by_id, lambda {|id| where(:id => id) if id.present?}
end
