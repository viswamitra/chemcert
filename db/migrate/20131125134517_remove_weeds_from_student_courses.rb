class RemoveWeedsFromStudentCourses < ActiveRecord::Migration
  def change
    remove_column :student_courses, :weeds
  end
end
