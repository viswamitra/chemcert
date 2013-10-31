class CreateVenueContacts < ActiveRecord::Migration
  def change
    create_table :venue_contacts do |t|
      t.column :venue_id, :bigint, :null => false
      t.string :name
      t.string :phone
      t.string :fax
      t.string :email
      t.timestamps
    end
  end
end
