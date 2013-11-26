class ChangeStudentDetails < ActiveRecord::Migration
  def change
    change_column :student_course_details, :student_id, :string
    drop_table :students
  end
end
