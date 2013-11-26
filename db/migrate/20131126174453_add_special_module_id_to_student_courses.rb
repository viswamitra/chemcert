class AddSpecialModuleIdToStudentCourses < ActiveRecord::Migration
  def change
    add_column :student_course_details, :additional_module_id, :bigint
  end
end
