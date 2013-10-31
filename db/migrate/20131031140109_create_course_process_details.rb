class CreateCourseProcessDetails < ActiveRecord::Migration
  def change
    create_table :course_process_details do |t|
      t.timestamp :performa_received_at
      t.timestamp :course_received_at
      t.string :course_finish_time
      t.string :venue_rating
      t.boolean :t4_received
      t.boolean :declaration_form_signed
      t.boolean :enrolment_form_signed
      t.string :inhouse_client
      t.float :cash_received
      t.string :trainer_invoice_po
      t.float :trainer_payment_amount
      t.string :enrolment_center_invoice
      t.boolean :course_status
      t.string comments
      t.timestamps
    end
  end
end
