class AddOtherSpecifyToDemographies < ActiveRecord::Migration
  def change
    add_column :student_demographies, :others_specify, :string
  end
end
