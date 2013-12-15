class StudentCourseDetailHistory < ActiveRecord::Base

  attr_accessible :student_id,:course_id, :student_course_id,
                  :enrolled_at, :student_course_id, :additional_module_id,
                  :industry, :needs_specify, :comments,
                  :course_fee, :payment_method, :payment_date,
                  :paid, :current_accreditation, :current_expiry_date, :enquiry,
                  :result, :special_modules

  belongs_to :student
  belongs_to :student_course
  belongs_to :course
  belongs_to :additional_module

end
