class RenameEnrolmentCenterInvoiceToQualityIndicators < ActiveRecord::Migration
  def change
    rename_column :course_process_details, :enrolment_center_invoice, :quality_indicators_received
  end
end
