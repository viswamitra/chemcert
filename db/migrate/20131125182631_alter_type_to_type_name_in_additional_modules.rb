class AlterTypeToTypeNameInAdditionalModules < ActiveRecord::Migration
  def change
    rename_column :additional_modules, :type, :type_name
  end
end
