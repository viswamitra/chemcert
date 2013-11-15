class Town < ActiveRecord::Base
  has_many :location_relations
  has_many :postal_codes, :through => :location_relations
  has_many :state, :through => :location_relations

  scope :by_id, lambda {|id| where(:id => id) if id.present? }
end
