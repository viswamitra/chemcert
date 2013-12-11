class StudentAddress < ActiveRecord::Base
  attr_accessible :student_id, :address, :location_relation_id, :home_location_relation_id,
                  :home_address


  belongs_to :student

  belongs_to :location_relation, class_name: 'LocationRelation', foreign_key: 'location_relation_id'
  belongs_to :home_location_relation, class_name: 'LocationRelation', foreign_key: 'home_location_relation_id'


end
