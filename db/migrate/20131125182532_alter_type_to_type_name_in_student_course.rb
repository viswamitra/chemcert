class AlterTypeToTypeNameInStudentCourse < ActiveRecord::Migration
  def change
    rename_column :student_courses, :type, :type_name
  end
end
