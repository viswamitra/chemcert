class ChangeEnrolmentColumnToInteger < ActiveRecord::Migration
  def change
    change_column :student_course_details, :enquiry, :integer
    change_column :student_course_detail_histories, :enquiry, :integer

  end
end
