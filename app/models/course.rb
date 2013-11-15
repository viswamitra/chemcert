class Course < ActiveRecord::Base

  belongs_to :training_organization
  belongs_to :location_relation
  belongs_to :venue
  belongs_to :trainer

  scope by_course_code, lamdba {|course_code| where(:course_code => course_code) if course_code.present?}
  scope by_course_date, lambda {|course_date| where(:course_date => course_date) if course_date.present?}

  def self.search(course_code, town_id, course_date)
    Course.joins(:location_relation => :town).merge
  end

end
