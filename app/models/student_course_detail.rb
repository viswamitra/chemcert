class StudentCourseDetail < ActiveRecord::Base

  attr_accessible :student_id,:course_id, :student_course_id

  belongs_to :student
  belongs_to :student_course
  belongs_to :course
  belongs_to :additional_module_
end
