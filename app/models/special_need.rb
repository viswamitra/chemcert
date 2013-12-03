class SpecialNeed < ActiveRecord::Base

  attr_accessible :need_type
  has_many :student_special_needs
  has_many :students, :through => :student_special_needs

end
