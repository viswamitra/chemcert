class Town < ActiveRecord::Base

  attr_accessible :name
  has_many :location_relations
  has_many :postal_codes, :through => :location_relations
  has_many :state, :through => :location_relations

  validates :name, :uniqueness => true, :presence => true



  scope :by_id, lambda {|id| where(:id => id) if id.present?}


  def self.by_matching_name(name)
    where("name like ?","%#{name}%");
  end

  def self.by_state(state_id)
    joins(:location_relations).where("location_relations.state_id = ?",state_id).uniq
  end
end
