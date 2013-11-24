class AddStudentCourseIdToStudentCourseDetails < ActiveRecord::Migration
  def change
    add_column :student_course_details, :student_course_id, :bigint, :null => false
  end
end
