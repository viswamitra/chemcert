class LocationRelation < ActiveRecord::Base

  attr_accessible :town_id, :state_id, :postal_code_id
  belongs_to :state
  belongs_to :town
  belongs_to :postal_code

  validates_uniqueness_of :state_id, :scope => [:town_id,:postal_code_id]
end
