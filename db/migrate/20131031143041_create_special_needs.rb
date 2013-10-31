class CreateSpecialNeeds < ActiveRecord::Migration
  def change
    create_table :special_needs do |t|
      #type {hearing/deaf, physical, intellectual, learning, mental,
      #   brain impairment, vision, medical condition}
      t.string :type
      t.timestamps
    end
  end
end
