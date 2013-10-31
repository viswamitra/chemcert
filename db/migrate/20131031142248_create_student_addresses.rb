class CreateStudentAddresses < ActiveRecord::Migration
  def change
    create_table :student_addresses do |t|
      t.column :student_id, :bigint, :null => false
      t.string :address
      t.column :location_relation_id, :bigint, :null => false
      t.string :home_address
      t.column :home_location_relation_id, :bigint, :null => false
      t.timestamps
    end
  end
end
