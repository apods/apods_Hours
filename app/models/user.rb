# == Schema Information
# Schema version: 20110515222920
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  first_name         :string(255)
#  last_name          :string(255)
#  encrypted_password :string(255)
#  password_salt      :string(255)
#  email              :string(255)
#  brother_status     :string(255)
#  peoplesoft_num     :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class User < ActiveRecord::Base
  
  attr_accessor :first_name, :last_name, :email
  
  validates_presence_of :first_name, :last_name, :email, :peoplesoft_num
  
  validates_length_of :first_name, :maximum => 32
  validates_length_of :last_name, :maximum => 32
  validates_length_of :peoplesoft_num, :is => 7
  
  validates_format_of :first_name, :with => /[a-z]+/i
  validates_format_of :last_name, :with => /[a-z]+/i
  validates_format_of :peoplesoft_num, :with => /[0-9]+/
  validates_format_of :email, :with => EmailRegex
  
  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :peoplesoft_num
  
end
