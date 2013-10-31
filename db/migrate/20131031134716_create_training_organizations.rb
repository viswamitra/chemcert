#this is RTO on the UI.
class CreateTrainingOrganizations < ActiveRecord::Migration
  def change
    create_table :training_organizations do |t|
      t.string :name
      t.string :provider
      t.timestamps
    end
  end
end
