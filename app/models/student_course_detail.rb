class StudentCourseDetail < ActiveRecord::Base

  attr_accessible :student_id,:course_id, :student_course_id,
                  :enrolled_at, :student_course_id, :addition_module_id,
                  :industry, :needs_specify, :comments,
                  :course_fee, :payment_method, :payment_date,
                  :paid, :current_accreditation, :current_expiry_date, :enquiry

  belongs_to :student
  belongs_to :student_course
  belongs_to :course
  belongs_to :additional_module


  def self.enroll_student(courses, bio, address, needs, demo, enquiry)
    begin
      ActiveRecord::Base.transaction do
        id = Student.create_unique_id
        location_relation = LocationRelation.where(:state_id => address["state_id"], :postal_code_id => address["postal_code"], :town_id => address["town_id"]).first
        student = Student.create(:student_id => id)
        assign_needs(needs, student)

        StudentCourseDetail.create!(:student_id => student.id, :course_id => 1,
        :enrolled_at => courses["enrolled_at"],
        :student_course_id => courses["course_types"],
        :addition_module_id => courses["additional_modules"],
        :industry => courses["industry"],
        :needs_specify => courses["needs_specify"],
        :comments => courses["comments"],
        :course_fee => courses["course_fee"],
        :payment_method => courses["payment_method"],
        :payment_date => courses["payment_date"],
        :paid => courses["paid"],
        :current_accreditation => courses["current_accreditation"],
        :current_expiry_date => courses["current_expiry_date"],
        :enquiry => enquiry
        )

        StudentBiodata.create!(:first_name => bio["first_name"],
                               :middle_name => bio["middle_name"],
                               :last_name => bio["last_name"],
                               :phone => bio["phone"],
                               :mobile => bio["mobile"],
                               :email => bio["email"],
                               :fax => bio["fax"],
                               :student_id => student.id)
        StudentAddress.create!(:student_id => student.id,
        :address => address["address"],
        :location_relation_id => location_relation.try(:id))

        StudentDemography.create!(:hear_about_chemcert => demo["feedback"],
        :others_specify => demo["feedback2"], :student_id => student.id, :demograhics_id => 1)

        student
      end
    rescue ActiveRecord::ActiveRecordError => e
      return nil #in case of exception return false
    end
  end

  def self.assign_needs(needs, student)
    return unless needs.present?
    needs.each do |k, v|
      n = SpecialNeed.where(:need_type => k)
      StudentSpecialNeed.create!(:student_id => student.id, :special_need_id => n.first.id)
    end
  end
end

