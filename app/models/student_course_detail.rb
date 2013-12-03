class StudentCourseDetail < ActiveRecord::Base

  attr_accessible :student_id,:course_id, :student_course_id

  belongs_to :student
  belongs_to :student_course
  belongs_to :course
  belongs_to :additional_module_


  validates_presence_of :course_fee

  def self.enroll_student(course_details, bio, address, needs, demo)
    begin
      ActiveRecord::Base.transaction do
        id = Student.create_unique_id
        Student.create!(:student_id => id)
        StudentCourseDetail


        true #return true here
      end
    rescue ActiveRecord::RecordInvalid => e
      return false #in case of exception return false
    end
  end



end

