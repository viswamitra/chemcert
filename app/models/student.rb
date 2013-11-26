class Student < ActiveRecord::Base
  has_many :student_addresses
  has_one :student_biodata
  has_one :student_demography
  has_many :student_course_details
  has_many :special_needs, :through => :student_special_needs
  has_many :student_special_needs

end
