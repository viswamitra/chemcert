class AlterBioDataAndCourseDetails < ActiveRecord::Migration
  def change
    remove_column :student_course_details, :student_bio_data_id
  end
end
