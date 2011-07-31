class AddStatusToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :status, :string
    add_index :users, :status
  end

  def self.down
    remove_column :users, :status
    remove_index :users, :status
  end
end
