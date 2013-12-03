class AddOthersSpecifyForCourseDetails < ActiveRecord::Migration
  def change
    add_column :student_course_details, :needs_specify, :string

  end
end
