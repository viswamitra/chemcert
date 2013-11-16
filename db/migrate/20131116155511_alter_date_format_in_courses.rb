class AlterDateFormatInCourses < ActiveRecord::Migration
  def change
    change_column :courses, :course_date, :date
  end
end
