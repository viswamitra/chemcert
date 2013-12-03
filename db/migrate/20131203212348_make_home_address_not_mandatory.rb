class MakeHomeAddressNotMandatory < ActiveRecord::Migration
  def change
    change_column :student_addresses, :home_location_relation_id, :bigint, null: true
  end
end
