class ChangeTypeInSpecialNeed < ActiveRecord::Migration
  def change
    rename_column :special_needs, :type, :need_type
  end
end
