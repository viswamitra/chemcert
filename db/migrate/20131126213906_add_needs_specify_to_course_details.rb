class AddNeedsSpecifyToCourseDetails < ActiveRecord::Migration
  def change
    add_column :course_process_details, :needs_specify, :string
  end
end
