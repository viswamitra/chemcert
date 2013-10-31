class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.column :training_organization_id, :bigint, :null => false
      t.boolean :is_correspondence
      t.string :course_code
      t.timestamp :course_date
      t.column :location_relation_id, :bigint, :null => false
      t.column :venue_id, :bigint, :null => false
      t.column :trainer_id, :bigint, :null => false
      t.timestamps
      t.index([:course_code], unique: true)
    end
  end
end
