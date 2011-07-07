class CreateHours < ActiveRecord::Migration
  def self.up
    create_table :hours do |t|
      t.integer :hours
      t.string :event
      t.string :date
      t.string :description
      t.integer :user_id

      t.timestamps
    end
    
    add_index :hours, :user_id
  end

  def self.down
    drop_table :hours
  end
end
