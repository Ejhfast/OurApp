class AddEntryIdToWinners < ActiveRecord::Migration
  def self.up
    add_column :winners, :entry_id, :integer
  end

  def self.down
    remove_column :winners, :entry_id
  end
end
