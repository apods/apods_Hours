class Hour < ActiveRecord::Base

  attr_accessible :hours, :event, :date, :description, :area_of_service
  
  belongs_to :user
  
  default_scope :order => 'created_at DESC'
  
  validates_presence_of :hours, :event, :user_id, :date
  
  validates_format_of :user_id, :with => /[0-9]+/
  
  validates_numericality_of :hours, :only_integer => true, :greater_than => 0, :less_than => 100
  
  validates_length_of :event, :maximum => 32, :too_long => " name must be less than 32 characters"
  validates_length_of :date, :maximum => 32
  validates_length_of :description, :maximum => 140
  
end
