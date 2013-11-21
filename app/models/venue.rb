class Venue < ActiveRecord::Base

  attr_accessible :name, :address, :room_name, :room_cost, :room_setup, :capacity, :location_relation_id,
                  :screen, :whiteboard_available, :catering, :lunch_available, :notes

  belongs_to :location_relation
  has_many :courses

  validates_presence_of :name
end
