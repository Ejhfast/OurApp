class CreateFriends < ActiveRecord::Migration
  def self.up
    create_table :friends do |t|
      t.integer :initiated
      t.integer :received

      t.timestamps
    end
  end

  def self.down
    drop_table :friends
  end
end
