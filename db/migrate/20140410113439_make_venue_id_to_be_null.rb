class MakeVenueIdToBeNull < ActiveRecord::Migration
  def change
    change_column :courses, :venue_id, :bigint, :null => true
  end
end
