class CreateStudentBiodata < ActiveRecord::Migration
  def change
    create_table :student_biodata do |t|
      t.column :student_id, :bigint, :null => false
      t.string :gender
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.timestamp :date_of_birth
      t.string :phone
      t.string :mobile
      t.string :email
      t.string :fax
      t.timestamps
    end
  end
end
