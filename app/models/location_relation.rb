class LocationRelation < ActiveRecord::Base
  belongs_to :state
  belongs_to :town
  belongs_to :postal_code

  accepts_nested_attributes_for :state

end
