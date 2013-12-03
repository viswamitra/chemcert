class StudentBiodata < ActiveRecord::Base
  attr_accessible :first_name, :middle_name, :last_name,
                  :phone, :mobile, :email, :fax,
                  :student_id

  belongs_to :student
end
