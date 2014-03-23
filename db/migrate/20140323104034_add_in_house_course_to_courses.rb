class AddInHouseCourseToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :in_house_course, :boolean
  end
end
