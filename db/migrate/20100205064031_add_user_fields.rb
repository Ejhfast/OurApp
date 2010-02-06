class AddUserFields < ActiveRecord::Migration
  def self.up
    add_column :users, :karma_current, :integer, :default => 20
    add_column :users, :karma_total, :integer, :default => 20
    add_column :users, :admin, :boolean
  end

  def self.down
    remove_column :users, :karma_current
    remove_column :users, :karma_total
    remove_column :users, :admin
  end
end
