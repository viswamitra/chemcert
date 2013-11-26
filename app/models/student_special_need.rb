class StudentSpecialNeed < ActiveRecord::Base
  belongs_to :student
  belongs_to :special_need

end
