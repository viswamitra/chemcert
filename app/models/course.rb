class Course < ActiveRecord::Base

  attr_accessible :location_relation_id, :training_organization_id,:is_correspondence, :course_code,
                  :course_date, :venue_id, :trainer_id

  belongs_to :training_organization
  belongs_to :location_relation
  belongs_to :venue
  belongs_to :trainer

  scope :by_course_code, lambda{|code| where(:course_code => code) if code.present?}
  scope :by_course_date, lambda {|date| where(:course_date => date) if date.present?}
  scope :by_town_id, lambda {|town_id| Course.joins(:location_relation => :town).merge(Town.by_id(town_id)) if town_id.present?}



  def self.search(course_code, town_id, course_date)
    return [] unless (course_code.present? || town_id.present? || course_date.present?)
    course_date = Time.parse(course_date).strftime('%Y-%m-%d') if course_date.present?
    Course.by_course_code(course_code).merge(by_course_date(course_date)).merge(by_town_id(town_id))
  end

  def self.by_matching_code(code)
    where("course_code like ?","%#{code}%")
  end


end
