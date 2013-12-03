class Student < ActiveRecord::Base

  attr_accessible :student_id

  has_many :student_addresses
  has_one :student_biodata
  has_one :student_demography
  has_many :student_course_details
  has_many :special_needs, :through => :student_special_needs
  has_many :student_special_needs


  def self.create_unique_id
    sql = ActiveRecord::Base.connection();
    num = sql.execute("select auto_increment from information_schema.tables where table_schema=database() and table_name = 'students'").to_a.first.first
    "ST"+num.to_s
  end

end
