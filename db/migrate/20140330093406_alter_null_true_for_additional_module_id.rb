class AlterNullTrueForAdditionalModuleId < ActiveRecord::Migration
  def change
    change_column :student_course_detail_histories, :additional_module_id, :bigint,  :null => true
  end
end
