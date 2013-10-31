class CreateDemographies < ActiveRecord::Migration
  def change
    create_table :demographies do |t|
      t.string :type
      t.timestamps
    end
  end
end
