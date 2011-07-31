class Hour < ActiveRecord::Base

  attr_accessible :hours, :event, :date, :description, :area_of_service
  
  belongs_to :user
  
  default_scope :order => 'created_at DESC'
  
  validates_presence_of :hours, :event, :user_id
  
  validates_format_of :hours, :with => /[0-9]+/
  validates_format_of :user_id, :with => /[0-9]+/
  
  validates_length_of :hours, :maximum => 3
  validates_length_of :event, :maximum => 32
  validates_length_of :date, :maximum => 32
  validates_length_of :description, :maximum => 140
  
end
