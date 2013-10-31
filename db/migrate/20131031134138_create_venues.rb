class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.column :location_relation_id, :bigint, :null => false
      t.string :room_name
      t.float :room_cost
      t.string :room_setup
      t.integer :capacity
      t.integer :screen
      t.boolean :whiteboard_available
      t.string :catering
      t.boolean :lunch_available
      t.notes :char
      t.timestamps
    end
  end
end
