class AddAreaOfServiceToHours < ActiveRecord::Migration
  def self.up
    add_column :hours, :area_of_service, :string
  end

  def self.down
    remove_column :hours, :area_of_service
  end
end
