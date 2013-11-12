class Course < ActiveRecord::Base

  belongs_to :training_organization
  belongs_to :location_relation
  belongs_to :venue

  accepts_nested_attributes_for :location_relation
  accepts_nested_attributes_for :training_organization


end
