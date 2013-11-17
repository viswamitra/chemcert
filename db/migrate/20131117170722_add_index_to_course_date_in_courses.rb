class AddIndexToCourseDateInCourses < ActiveRecord::Migration
  def change
    add_index :courses, :course_date
  end
end
