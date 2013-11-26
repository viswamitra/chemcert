class SpecialNeed < ActiveRecord::Base
  has_many :student_special_needs
  has_many :students, :through => :student_special_needs
end
