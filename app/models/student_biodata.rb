class StudentBiodata < ActiveRecord::Base
  attr_accessible :first_name, :middle_name, :last_name,
                  :phone, :mobile, :email, :fax,
                  :student_id, :date_of_birth, :gender

  belongs_to :student
end
