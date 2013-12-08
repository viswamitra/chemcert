class Course < ActiveRecord::Base

  attr_accessible :location_relation_id, :training_organization_id,:is_correspondence, :course_code,
                  :course_date, :venue_id, :trainer_id, :course_status

  belongs_to :training_organization
  belongs_to :location_relation
  belongs_to :venue
  belongs_to :trainer
  has_many :student_course_details

  has_one :course_process_detail

  scope :by_course_code, lambda{|code| where(:course_code => code) if code.present?}
  scope :by_course_date, lambda {|date| where(:course_date => date) if date.present?}
  scope :by_town_id, lambda {|town_id| Course.joins(:location_relation => :town).merge(Town.by_id(town_id)) if town_id.present?}
  scope :by_state_id, lambda {|state_id| Course.joins(:location_relation => :state).merge(State.by_id(state_id)) if state_id.present?}
  scope :by_start_date, lambda {|date| Course.where('course_date >= ?',date) if date.present?}
  scope :by_end_date, lambda {|date| Course.where('course_date <= ?',date) if date.present?}




  def self.by_course_status(status)
     if status == 'open'
       where(:course_status => false)
     elsif status == 'closed'
       where(:course_status => true)
     elsif status == 'payment_pending'
       #joins(:students).
     end
  end

  def self.search(course_code, town_id, course_date)
    return [] unless (course_code.present? || town_id.present? || course_date.present?)
    course_date = Time.parse(course_date).strftime('%Y-%m-%d') if course_date.present?
    Course.by_course_code(course_code).merge(by_course_date(course_date)).merge(by_town_id(town_id))
  end

  def self.search_by_schedule(start_date, end_date, state_id)
     return [] unless (start_date.present? || end_date.present? || state_id.present?)
     start_date = Time.parse(start_date).strftime('%Y-%m-%d') if start_date.present?
     end_date = Time.parse(end_date).strftime('%Y-%m-%d') if end_date.present?
     Course.between_dates(start_date, end_date).merge(by_state_id(state_id))
  end

  def self.search_process(course_code, course_status, start_date, end_date)
    return [] unless (course_code.present? || course_status.present? || start_date.present? || end_date.present?)
    start_date = Time.parse(start_date).strftime('%Y-%m-%d') if start_date.present?
    end_date = Time.parse(end_date).strftime('%Y-%m-%d') if end_date.present?
    Course.by_start_date(start_date).merge(by_end_date(end_date)).merge(by_course_status(course_status)).merge(by_course_code(course_code))
  end

  def self.between_dates(start_date, end_date)
    by_start_date(start_date).merge(by_end_date(end_date))
  end

  def self.by_matching_code(code)
    where("course_code like ?","%#{code}%")
  end

  #to include student_course_details also.
  def self.search_for_processing(code)
    Course.includes(:student_course_details).where(:course_code => code)
  end

end

