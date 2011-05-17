# == Schema Information
# Schema version: 20110516015845
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

require 'digest'
class User < ActiveRecord::Base
  
  before_save :encrypt_password
  
  attr_accessor :password
  attr_accessible :first_name, :last_name, :peoplesoft_num, :email, :password, :password_confirmation
  
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates_presence_of :first_name, :last_name, :email, :peoplesoft_num, :password
  
  validates_length_of :first_name, :maximum => 32
  validates_length_of :last_name, :maximum => 32
  validates_length_of :peoplesoft_num, :is => 7
  
  validates_format_of :first_name, :with => /[a-z]+/i
  validates_format_of :last_name, :with => /[a-z]+/i
  validates_format_of :peoplesoft_num, :with => /[0-9]+/
  validates_format_of :email, :with => EmailRegex
  
  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :peoplesoft_num
  
  validates_confirmation_of :password
  validates_length_of :password, :within => 6..40
  
  
  # Authenticate a user, return nil if user does not exist or password doesn't match
  def self.authenticate(submitted_peoplesoft_num, submitted_password)
    user = find_by_peoplesoft_num(submitted_peoplesoft_num)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
    return nil
  end
  
  # Check to see if submitted password is correct
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  # Set a token used to remember a user for a session after a log in
  def remember_me!
    self.remember_token = encrypt("#{salt}--#{id}--#{Time.now.utc}")
    save_without_validation
  end
  
  # Private methods for encryption
  private
    
    def encrypt_password
      unless password.nil?        # needed because even a save_without_validation will trip this function
        self.password_salt = make_salt
        self.encrypted_password = encrypt(password)
      end
    end
    
    def encrypt(string)
      secure_hash("#{password_salt}#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
