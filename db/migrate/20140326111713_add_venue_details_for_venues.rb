class AddVenueDetailsForVenues < ActiveRecord::Migration
  def change
    add_column :venues, :contact, :string
    add_column :venues, :number, :string
  end
end
