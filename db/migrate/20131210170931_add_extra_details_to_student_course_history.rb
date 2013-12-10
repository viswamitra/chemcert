class AddExtraDetailsToStudentCourseHistory < ActiveRecord::Migration
  def change
    add_column :student_course_detail_histories, :student_course_id, :bigint, null: false
    add_column :student_course_detail_histories, :additional_module_id, :bigint, null: false
    add_column :student_course_detail_histories, :industry, :string
    add_column :student_course_detail_histories, :needs_specify, :string
  end
end

