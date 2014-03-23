class AlterCourseStatusIdInCourse < ActiveRecord::Migration
  def change
    change_column :courses, :course_status_id, :bigint, :null => true

  end
end
