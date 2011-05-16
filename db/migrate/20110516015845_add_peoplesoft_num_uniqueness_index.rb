class AddPeoplesoftNumUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :peoplesoft_num, :unique => true
  end

  def self.down
    remove_index :users, :peoplesoft_num
  end
end
