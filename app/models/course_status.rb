class CourseStatus < ActiveRecord::Base

  attr_accessible :status

  has_many :courses

end
