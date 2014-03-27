class AlterCurrentExpiryDateInStudnetCourseDetail < ActiveRecord::Migration
  def change
    change_column :student_course_details, :current_expiry_date, :date
    change_column :student_course_detail_histories, :current_expiry_date, :date
  end
end
