class AlterCourseStatusToIdInCourse < ActiveRecord::Migration
  def change
    remove_column :courses, :course_status
    add_column :courses, :course_status_id, :bigint, :null => false
  end
end
