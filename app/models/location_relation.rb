class LocationRelation < ActiveRecord::Base

  attr_accessible :town_id, :state_id, :postal_code_id
  belongs_to :state
  belongs_to :town
  belongs_to :postal_code


  validates_uniqueness_of :state_id, :scope => [:town_id,:postal_code_id]

  def self.by_postal_code(code)
    joins(:postal_code).where("postal_codes.code = ?",code).map do |lr|
      {:id => lr.id,
       :postal_code_id => lr.postal_code.id,
       :postal_code => lr.postal_code.code,
       :town_id => lr.town.id,
       :town => lr.town.name,
       :state_id => lr.state.id,
       :state => lr.state.name}
    end
  end


end
