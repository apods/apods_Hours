class Hour < ActiveRecord::Base

  attr_accessible :hours, :event, :date, :description
  
  belongs_to :user
  
  default_scope :order => 'created_at DESC'
  
  validates_presence_of :hours, :event, :user_id
  
  validates_format_of :hours, :with => /[0-9]+/
  validates_format_of :user_id, :with => /[0-9]+/
  
end
