class ChangeAdditionalModuleNameInStudentCourseDetail < ActiveRecord::Migration
  def change
    rename_column :student_course_details, :addition_module_id, :additional_module_id
  end
end
