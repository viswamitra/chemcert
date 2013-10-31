class CreateStudent < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :student_id
      t.string :usi_id
      t.index([:student_id], unique: true)
    end
  end
end
