class Student < ActiveRecord::Base

  attr_accessible :student_id


  has_one :student_address
  has_one :student_biodata
  has_one :student_demography
  has_one :student_course_detail
  has_many :student_course_detail_histories
  has_many :special_needs, :through => :student_special_needs
  has_many :student_special_needs



  #scopes
  scope :by_first_name, lambda{|name| Student.joins(:student_biodata).where('student_biodata.first_name = ?',name) if name.present?}
  scope :by_last_name, lambda{|name| Student.joins(:student_biodata).where('student_biodata.last_name = ?',name) if name.present?}
  scope :by_student_id, lambda{|id| Student.where(:student_id => id) if id.present?}
  scope :by_enquiry, lambda{|enquiry| Student.joins(:student_course_detail).where('student_course_details.enquiry = ?',enquiry) if enquiry.present?}
  scope :by_state_id, lambda {|state_id| Student.joins(:student_address => :location_relation).where('location_relations.state_id = ?', state_id) if state_id.present?}


  scope :by_state_id, lambda {|state_id|
    if state_id.present?
      Student.joins(:student_address => :location_relation).where('location_relations.state_id = ?', state_id.to_i)
    else
      states = State.all.map {|s| s.id}
      Student.joins(:student_address => :location_relation).where('location_relations.state_id in (?)', states)
    end

  }

  scope :by_enquiry, lambda{|enquiry|
    if enquiry.present?
      Student.joins(:student_course_detail).where('student_course_details.enquiry = ?',enquiry.to_i)
    else
      enquiries = [0,1,2] # { 0 - enquiry, 1- enrolment, 2- completed}
      Student.joins(:student_course_detail).where('student_course_details.enquiry in (?)',enquiries)
    end
  }


  def self.create_unique_id
    #should modify this to accomodate a true random number.
    sql = ActiveRecord::Base.connection();
    num = sql.execute("select auto_increment from information_schema.tables where table_schema=database() and table_name = 'students'").to_a.first.first
    "ST"+num.to_s
  end

  def self.search(first_name, last_name, student_id, enquiry, state_id)
    #return [] unless (first_name.present? || last_name.present? || student_id.present? || enquiry.present? )
    Student.by_first_name(first_name).merge(self.by_last_name(last_name)).merge(self.by_student_id(student_id)).merge(self.by_enquiry(enquiry)).merge(self.by_state_id(state_id))
  end

end
