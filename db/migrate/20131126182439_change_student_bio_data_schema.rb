class ChangeStudentBioDataSchema < ActiveRecord::Migration
  def change
    remove_column :student_biodata, :student_id
    add_column :student_course_details, :student_bio_data_id, :bigint, null: false
  end
end
