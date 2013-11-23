class CourseProcessDetail < ActiveRecord::Base

  attr_accessible :performa_received_at, :course_received_at, :course_finish_time,
                :venue_rating, :t4_received, :declaration_form_signed, :enrolment_form_signed,
                :inhouse_client, :cash_received, :trainer_invoice_po, :trainer_payment_amount,
                :enrolment_center_invoice, :course_status, :comments, :course_id

  belongs_to :course

end
