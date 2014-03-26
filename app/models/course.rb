class Course < ActiveRecord::Base

  attr_accessible :location_relation_id, :training_organization_id,:is_correspondence, :course_code,
                  :course_date, :venue_id, :trainer_id, :course_status_id, :in_house_course, :in_house_course_name

  validates_uniqueness_of :course_code

  belongs_to :training_organization
  belongs_to :location_relation
  belongs_to :venue
  belongs_to :trainer
  belongs_to :course_status
  has_many :student_course_details
  has_many :student_course_detail_histories

  has_one :course_process_detail

  scope :by_course_code, lambda{|code| where(:course_code => code) if code.present?}
  scope :by_course_date, lambda {|date| where(:course_date => date) if date.present?}
  #adding only open courses to show as available in that particular town.
  scope :by_town_id, lambda {|town_id| Course.joins(:location_relation => :town).merge(Town.by_id(town_id)).where(:course_status_id =>  1) if town_id.present?}

  scope :by_start_date, lambda {|date| Course.where('course_date >= ?',date) if date.present?}
  scope :by_end_date, lambda {|date| Course.where('course_date <= ?',date) if date.present?}


  scope :by_state_id, lambda {|state_id|
    if (state_id.to_i != 0)
      Course.joins(:location_relation => :state).merge(State.by_id(state_id))
    else
      states = State.all.map {|s| s.id}
      Course.joins(:location_relation => :state).merge(State.by_id(states))
    end

  }




  def self.by_course_status(status)
    status = status.to_i
    #hard coding for payment pending which is not a db state. Have to modify this in case of any external additions.
    if status == 7
       joins(:student_course_details).where('student_course_details.paid = ?',false)
    elsif status == 0
      statuses = CourseStatus.all.map {|cs| cs.id }
      where('course_status_id in (?)',statuses)
    else
       where(:course_status_id => status)
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

  def self.by_open_mode(code)
    where("course_code like ? and course_status_id = ?","%#{code}%", 0)
  end

  #to include student_course_details also.
  def self.search_for_processing(code)
    Course.includes(:student_course_details).where(:course_code => code)
  end

  def generate_merge_txt(enrolment_type)
    CSV.generate do |csv|
      csv << ["Student_No","First_Name","Surname","Address1","Address2","Suburb","State","Postcode","Instructor","RTO","Original_Course_Date",
              "Last_Course_Date","Expiry_Date","Location","SpecialModule1","SpecialModule2","SpecialModule3"]

      scd = self.student_course_details.where('enquiry in ?',enrolment_type)

      scd.each do |student_detail|
        student_no = student_detail.try(:student).try(:student_id).present? ? student_detail.student.student_id : ""
        first_name = student_detail.try(:student).try(:student_biodata).try(:first_name).present? ? student_detail.student.student_biodata.first_name : ""
        surname = student_detail.try(:student).try(:student_biodata).try(:last_name).present? ? student_detail.student.student_biodata.last_name : ""
        address = student_detail.try(:student).try(:student_address).try(:address).present? ? student_detail.student.student_address.address : ""
        suburb = student_detail.try(:student).try(:student_address).try(:location_relation).try(:town).try(:name).present? ? student_detail.student.student_address.location_relation.town.name : ""
        state = student_detail.try(:student).try(:student_address).try(:location_relation).try(:state).try(:name).present? ? student_detail.student.student_address.location_relation.state.name : ""
        postal_code = student_detail.try(:student).try(:student_address).try(:location_relation).try(:postal_code).try(:code).present? ? student_detail.student.student_address.location_relation.postal_code.code : ""
        instructor = student_detail.try(:course).try(:trainer).try(:name).present? ? student_detail.course.trainer.name : ""
        rto = student_detail.try(:course).try(:training_organization).try(:name).present? ? student_detail.course.training_organization.name : ""
        original_course_date = student_detail.try(:student).try(:student_course_detail_histories).try(:first).try(:course).try(:course_date).present? ? student_detail.student.student_course_detail_histories.first.course.course_date : ""
        last_course_date = student_detail.try(:course).try(:course_date).present? ? student_detail.course.course_date : ""
        expirty_date = student_detail.try(:current_expiry_date).present? ? student_detail.current_expiry_date : ""
        location = student_detail.try(:course).try(:location_relation).try(:town).try(:name).present? ? student_detail.course.location_relation.town.name : ""
        special_module = student_detail.try(:additional_module).try(:type_name).present? ? student_detail.additional_module.type_name : ""



        csv << [
            student_no,
            first_name,
            surname,
            address,
            "",
            suburb,
            state,
            postal_code,
            instructor,
            rto,
            original_course_date,
            last_course_date,
            expirty_date,
            location,
            special_module,
            "",
            ""
        ]
      end
    end
  end


  def generate_confirmation_csv(enrolment_type)
    CSV.generate do |csv|
      csv << ["Student_No","First_Name","Surname","Address1","Address2","Suburb","State","Postcode","Instructor","RTO","Original_Course_Date",
              "Last_Course_Date","Expiry_Date","Location","SpecialModule1","SpecialModule2","SpecialModule3"]

      scd = self.student_course_details.where('enquiry in ?',enrolment_type)

      scd.each do |student_detail|
        student_no = student_detail.try(:student).try(:student_id).present? ? student_detail.student.student_id : ""
        first_name = student_detail.try(:student).try(:student_biodata).try(:first_name).present? ? student_detail.student.student_biodata.first_name : ""
        surname = student_detail.try(:student).try(:student_biodata).try(:last_name).present? ? student_detail.student.student_biodata.last_name : ""
        address = student_detail.try(:student).try(:student_address).try(:address).present? ? student_detail.student.student_address.address : ""
        suburb = student_detail.try(:student).try(:student_address).try(:location_relation).try(:town).try(:name).present? ? student_detail.student.student_address.location_relation.town.name : ""
        state = student_detail.try(:student).try(:student_address).try(:location_relation).try(:state).try(:name).present? ? student_detail.student.student_address.location_relation.state.name : ""
        postal_code = student_detail.try(:student).try(:student_address).try(:location_relation).try(:postal_code).try(:code).present? ? student_detail.student.student_address.location_relation.postal_code.code : ""
        instructor = student_detail.try(:course).try(:trainer).try(:name).present? ? student_detail.course.trainer.name : ""
        rto = student_detail.try(:course).try(:training_organization).try(:name).present? ? student_detail.course.training_organization.name : ""
        original_course_date = student_detail.try(:student).try(:student_course_detail_histories).try(:first).try(:course).try(:course_date).present? ? student_detail.student.student_course_detail_histories.first.course.course_date : ""
        last_course_date = student_detail.try(:course).try(:course_date).present? ? student_detail.course.course_date : ""
        expirty_date = student_detail.try(:current_expiry_date).present? ? student_detail.current_expiry_date : ""
        location = student_detail.try(:course).try(:location_relation).try(:town).try(:name).present? ? student_detail.course.location_relation.town.name : ""
        special_module = student_detail.try(:additional_module).try(:type_name).present? ? student_detail.additional_module.type_name : ""



        csv << [
            student_no,
            first_name,
            surname,
            address,
            "",
            suburb,
            state,
            postal_code,
            instructor,
            rto,
            original_course_date,
            last_course_date,
            expirty_date,
            location,
            special_module,
            "",
            ""
        ]
      end
    end
  end

  def generate_proforma_csv(proforma_type)
    CSV.generate do |csv|
      csv << ["Course Date", self.course_date, "Venue", self.venue.try(:name)]
      csv << ["Start time","", "Venue Address", self.venue.try(:address)]
      csv << ["Course Finish Time", "","Venue Town", self.venue.location_relation.try(:town).try(:name)]
      csv << ["Course Code", self.course_code, "Venue State", self.venue.location_relation.try(:state).try(:name)]
      csv << ["Trainer", self.trainer.name, "Venue Contact", self.venue.try(:contact)]
      csv << ["Catering Contact", self.venue.catering, "Venue number", self.venue.try(:number)]
      csv << ["Catering Arrangements",""]
      csv << []
      csv << []
      csv << []


      csv << ["Sl.no","Student No","Name","Industry","Control Weeds/learner Needs/Comments","Attendance","Amount Payable","Pay Method","No enrolment Form","No workbook", "NYC/AQFII/AQFIV"]
      id = 1
      scd = self.student_course_details.joins(:student_course).where('student_course_details.enquiry = ? and student_courses.type_name = ?',1, proforma_type)
      scd.each do |student_detail|
        csv << [id, student_detail.student.student_id,
                student_detail.student.student_biodata.first_name+" "+student_detail.student.student_biodata.last_name,
                student_detail.industry,
                "",
                "",
                student_detail.course_fee,
                student_detail.payment_method,
                "",
                "",
                ""
                ]
        id +=1
      end
    end
  end

end

