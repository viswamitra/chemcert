class AddT6T10ReceivedToCourseProcessDetails < ActiveRecord::Migration
  def change
    add_column :course_process_details, :t6_received, :boolean
    add_column :course_process_details, :t10_received, :boolean
  end
end
