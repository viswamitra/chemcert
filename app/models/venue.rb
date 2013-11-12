class Venue < ActiveRecord::Base
  belongs_to :location_relation
  has_many :courses
end
