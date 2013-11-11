class Course < ActiveRecord::Base

  belongs_to :rto
  belongs_to :state,
end
