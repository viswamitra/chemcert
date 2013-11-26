class AlterStudentsSchema < ActiveRecord::Migration
  def change
    change_column :student_course_details, :student_id, :bigint, null: false
    add_column :student_biodata, :student_id, :bigint, null: false
  end
end
