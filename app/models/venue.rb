class Venue < ActiveRecord::Base

  attr_accessible :name, :address, :room_name, :room_cost, :room_setup, :capacity, :location_relation_id,
                  :screen, :whiteboard_available, :catering, :lunch_available, :notes

  belongs_to :location_relation
  has_many :courses

  validates_presence_of :name

  scope :by_town_id, lambda {|town_id| Venue.joins(:location_relation => :town).merge(Town.by_id(town_id)) if town_id.present?}



  def self.by_course(id)
    Venue.joins(:courses).where('courses.id = ?',id)
  end

  def self.search(town_id)
    return [] unless town_id.present?
    Venue.by_town_id(town_id)
  end
end
