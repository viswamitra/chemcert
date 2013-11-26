class AddIndustrytoStudentCourseDetails < ActiveRecord::Migration
  def change
    add_column :student_course_details, :industry, :string
  end
end
