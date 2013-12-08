class StudentAddress < ActiveRecord::Base
  attr_accessible :student_id, :address, :location_relation_id


  belongs_to :student
  belongs_to :location_relation
end
