class CreateStudentSpecialNeeds < ActiveRecord::Migration
  def change
    create_table :student_special_needs do |t|
      t.column :student_id, :bigint, :null => false
      t.column :special_need_id, :bigint, :null => false
    end
  end
end
