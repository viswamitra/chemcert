class LocationRelation < ActiveRecord::Base
  belongs_to :state
  belongs_to :town
  belongs_to :postal_code
end
