class CreateAdditionalModules < ActiveRecord::Migration
  def change
    create_table :additional_modules do |t|
      t.string :type
      t.timestamps
    end
  end
end
