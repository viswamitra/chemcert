class CreateLocationRelations < ActiveRecord::Migration
  def change
    create_table :location_relations do |t|
      t.column :town_id, :bigint, :null => false
      t.column :state_id, :bigint, :null => false
      t.column :postal_code_id, :bigint, :null => false
      t.boolean course_enabled
      t.timestamps

      t.index([:town_id, :state_id, :postal_code_id], unique => true)
    end
  end
end
