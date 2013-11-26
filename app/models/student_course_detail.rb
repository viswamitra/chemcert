class StudentCourseDetail < ActiveRecord::Base

  attr_accessible :student_id,:course_id, :student_course_id

  belongs_to :student_course
  belongs_to :student_
end
