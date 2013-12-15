class CourseProcessDetail < ActiveRecord::Base

  attr_accessible :performa_received_at, :course_received_at, :course_finish_time,
                :venue_rating, :t4_received, :declaration_form_signed, :enrolment_form_signed,
                :inhouse_client, :cash_received, :trainer_invoice_po, :trainer_payment_amount,
                :enrolment_center_invoice, :course_status, :comments, :course_id

  belongs_to :course

  def self.create_process_detail(course)
    begin
      ActiveRecord::Base.transaction do
        crs = Course.find_by_course_code(course["course_code"])
        CourseProcessDetail.create!(:performa_received_at => course["proforma_received"],
                                    :course_received_at => course["course_received"],
                                    :course_id => crs.try(:id),
                                    :course_finish_time => course["course_finish_time"],
                                    :venue_rating => course["venue_rating"],
                                    :t4_received => course["t4_received"],
                                    :declaration_form_signed => course["declaration_form_signed"],
                                    :enrolment_form_signed => course["enrolment_form_signed"],
                                    :inhouse_client => course["inhouse_client_name"],
                                    :cash_received => course["cash_received"],
                                    :trainer_invoice_po => course["trainer_invoice"],
                                    :trainer_payment_amount => course["trainer_payment"],
                                    :enrolment_center_invoice => course["enrolment_center_invoice"],
                                    :comments => course["comments"])

        # cannot close the course if any of the students are not paid for that course yet.

        if(course["status"])
          student_course_details = crs.student_course_details.where(enquiry: 1)
          course_validation(student_course_details)
          update_course_expiry_date(student_course_details)
          update_student_course_detail_history(student_course_details)
        end




        crs.update_attributes!(:course_status => course["status"])

        {:error => nil, :success => true}
      end

    rescue CannotCloseCourseException
      error = "Cannot close course while students are not paid"
      {:error => error, :success => false}

    rescue ActiveRecord::ActiveRecordError => e
      {:error => e.message, :success => false}
      #return nil #in case of exception return false
    end
  end

  def self.course_validation(student_course_details)
    res = true
    student_course_details.each do |detail|
      res = res && detail.paid
      unless res
        raise CannotCloseCourseException
        break
      end
    end
  end

  def self.update_course_expiry_date(student_course_details)
    begin
      student_course_details.each do |detail|
        course_date_str = detail.course.course_date.to_s
        course_date_time = Time.parse(course_date_str)
        current_expiry_date = Time.mktime(course_date_time.year+5, course_date_time.month,course_date_time.day)
        current_expiry_date = Date.parse(current_expiry_date.to_s)
        detail.update!(:current_expiry_date => current_expiry_date)
      end
    rescue Exception => e
      {:error => e.message, :success => false}
    end
  end

  def self.update_student_course_detail_history(student_course_details)
    begin
      student_course_details.each do |detail|
        StudentCourseDetailHistory.create!(:student_id => detail.student_id,
                                       :course_id => detail.course_id,
                                       :enrolled_at => detail.enrolled_at,
                                       :result => detail.result,
                                       :special_modules => detail.special_modules,
                                       :comments => detail.comments,
                                       :course_fee => detail.course_fee,
                                       :payment_method => detail.payment_method,
                                       :payment_date => detail.payment_date,
                                       :paid => detail.paid,
                                       :enquiry => detail.enquiry,
                                       :current_accreditation => detail.current_accreditation,
                                       :current_expiry_date => detail.current_expiry_date,
                                       :student_course_id => detail.student_course_id,
                                       :additional_module_id => detail.additional_module_id,
                                       :industry => detail.industry,
                                       :needs_specify => detail.needs_specify
                                       )

        end
    rescue Exception => e
      {:error => e.message, :success => false}
    end


  end


end
