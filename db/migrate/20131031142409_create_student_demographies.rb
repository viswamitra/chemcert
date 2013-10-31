class CreateStudentDemographies < ActiveRecord::Migration
  def change
    create_table :student_demographies do |t|
      t.column :student_id, :bigint, :null => false
      t.column :demograhics_id, :bigint, :null => false
      t.string :hear_about_chemcert
      t.string :country_of_birth
      t.string :residency_status
      t.string :employment_status
      t.string :highest_education_level
      t.string :qualification_level
      t.string :study_reason
      t.string :notes
      t.timestamps
    end
  end
end
