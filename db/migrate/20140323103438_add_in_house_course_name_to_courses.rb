class AddInHouseCourseNameToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :in_house_course_name, :string
  end
end
