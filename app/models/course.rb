class Course < ActiveRecord::Base

  belongs_to :training_organization
  belongs_to :location_relation
  belongs_to :venue
  belongs_to :trainer

  def self.by_town(town)
    Course.joins(:location_relation => :town).where('towns.id = ?',town)
  end

  def self.search(course_code, town_id, course_date)
    by_town(town_id).where(:course_code => course_code, :course_date => course_date).to_a
  end


end
