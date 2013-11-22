class AddCourseIdToCourseProcessDetails < ActiveRecord::Migration
  def change
    add_column :course_process_details, :course_id, :bigint, :null => false
  end
end
