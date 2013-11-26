class CreateStudentBioData < ActiveRecord::Migration
  def change
    create_table :student_bio_data do |t|

      t.timestamps
    end
  end
end
