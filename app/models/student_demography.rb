class StudentDemography < ActiveRecord::Base
  #TODO: need to change the demographics_id to something later on.
  attr_accessible :hear_about_chemcert, :others_specify, :student_id, :demograhics_id
  belongs_to :student
end
