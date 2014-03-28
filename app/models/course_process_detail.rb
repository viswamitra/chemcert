class CourseProcessDetail < ActiveRecord::Base

  attr_accessible :performa_received_at, :course_received_at, :course_finish_time,
                :venue_rating, :t4_received,:t6_received,:t10_received, :declaration_form_signed,
                :enrolment_form_signed,:inhouse_client, :cash_received, :trainer_invoice_po, :trainer_payment_amount,
                :quality_indicators_received, :course_status, :comments, :course_id

  belongs_to :course

  def self.create_process_detail(course)
    begin
      ActiveRecord::Base.transaction do
        crs = Course.find_by_course_code(course["course_code"])
        course_process_detail = crs.course_process_detail

        if course_process_detail.present?
          course_process_detail.update!(:performa_received_at => course["proforma_received"],
          :course_received_at => course["course_received"],
              :course_finish_time => course["course_finish_time"],
          :venue_rating => course["venue_rating"],
          :t4_received => course["t4_received"],
          :t6_received => course["t6_received"],
          :t10_received => course["t10_received"],
          :declaration_form_signed => course["declaration_form_signed"],
          :enrolment_form_signed => course["enrolment_form_signed"],
          :inhouse_client => course["inhouse_client_name"],
          :cash_received => course["cash_received"],
          :trainer_invoice_po => course["trainer_invoice"],
          :trainer_payment_amount => course["trainer_payment"],
          :quality_indicators_received => course["quality_indicators_received"],
          :comments => course["comments"])

        else
          CourseProcessDetail.create!(:performa_received_at => course["proforma_received"],
                                      :course_received_at => course["course_received"],
                                      :course_id => crs.try(:id),
                                      :course_finish_time => course["course_finish_time"],
                                      :venue_rating => course["venue_rating"],
                                      :t4_received => course["t4_received"],
                                      :t6_received => course["t6_received"],
                                      :t10_received => course["t10_received"],
                                      :declaration_form_signed => course["declaration_form_signed"],
                                      :enrolment_form_signed => course["enrolment_form_signed"],
                                      :inhouse_client => course["inhouse_client_name"],
                                      :cash_received => course["cash_received"],
                                      :trainer_invoice_po => course["trainer_invoice"],
                                      :trainer_payment_amount => course["trainer_payment"],
                                      :quality_indicators_received => course["quality_indicators_received"],
                                      :comments => course["comments"])
        end


        # cannot close the course if any of the students are not paid for that course yet.

        # 2 is course closed
        course_status = CourseStatus.where(status: "closed")
        if(course["status"].to_i == course_status.first.id)
          p "---> course is closed"
          student_course_details = crs.student_course_details.where(enquiry: 1)
          #course_validation(student_course_details)
          update_course_expiry_date(student_course_details)
          update_student_course_detail_history(student_course_details)
        end

        crs.update_attributes!(:course_status_id => course["status"].to_i)

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
        detail.update!(:enquiry => 2)
      end
    rescue Exception => e
      {:error => e.message, :success => false}
    end
  end

  def self.update_student_course_detail_history(student_course_details)

    begin
      student_course_details.each do |detail|


        histories = StudentCourseDetailHistory.find_or_initialize_by(student_id: detail.student_id, course_id: detail.course_id)

        histories.update_attributes!(:student_id => detail.student_id,
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
