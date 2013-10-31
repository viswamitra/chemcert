class CreateStudentCourses < ActiveRecord::Migration
  def change
    create_table :student_courses do |t|
      t.string :type
      t.boolean :weeds
      t.timestamps
    end
  end
end
