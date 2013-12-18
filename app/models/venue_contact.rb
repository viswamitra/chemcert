class VenueContact < ActiveRecord::Base
  attr_accessible :name, :phone, :fax, :email

  belongs_to :venue

end
