class CreateStudentCourseDetailHistories < ActiveRecord::Migration
  def change
    create_table :student_course_detail_histories do |t|
      t.column :student_id, :bigint, :null => false
      t.column :course_id, :bigint, :null => false
      t.timestamp :enrolled_at
      t.string :result
      t.string :special_modules
      t.string :comments
      t.float :course_fee
      t.string :payment_method
      t.timestamp :payment_date
      t.boolean :paid
      t.boolean :enquiry
      t.string :current_accreditation
      t.timestamp :current_expiry_date
      t.timestamps
    end
  end
end
