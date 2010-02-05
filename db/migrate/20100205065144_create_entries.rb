class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :user_id
      t.integer :request_id
      t.integer :flags

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
