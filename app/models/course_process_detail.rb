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

        crs.update_attributes!(:course_status => course["status"])
        # if course is closed, then fetch all the student_course_details for that course and add them to student_course_detail_histories.

        {:error => nil, :success => true}
      end

    rescue ActiveRecord::ActiveRecordError => e
      {:error => e.message, :success => false}
      #return nil #in case of exception return false
    end
  end


end
