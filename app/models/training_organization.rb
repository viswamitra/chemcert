class TrainingOrganization < ActiveRecord::Base
  attr_accessible :name, :provider

  has_many :courses

  validates_presence_of :name

end
