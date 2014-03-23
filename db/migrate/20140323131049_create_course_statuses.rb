class CreateCourseStatuses < ActiveRecord::Migration
  def change
    create_table :course_statuses do |t|
      #status can be {open, closed, missing payments, missing workbooks,
      # missing enrolment forms, awaiting competencies not signed}
      t.string :status
      t.timestamps
    end
  end
end
