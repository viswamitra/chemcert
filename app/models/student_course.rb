class StudentCourse < ActiveRecord::Base
  attr_accessible :type_name

  has_many :student_course_detail
end
