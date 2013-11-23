class RemoveCourseStatusFromCourseProcessDetails < ActiveRecord::Migration
  def change
    remove_column :course_process_details, :course_status
    add_column :courses, :course_status, :boolean, :default => false
  end
end
