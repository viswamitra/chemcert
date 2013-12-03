class StudentSpecialNeed < ActiveRecord::Base
  attr_accessible :special_need_id, :student_id
  belongs_to :student
  belongs_to :special_need

end
