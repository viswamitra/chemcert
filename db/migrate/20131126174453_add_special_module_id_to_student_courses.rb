class AddSpecialModuleIdToStudentCourses < ActiveRecord::Migration
  def change
    add_column :student_course_details, :addition_module_id, :bigint
  end
end
