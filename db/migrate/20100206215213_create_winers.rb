class CreateWiners < ActiveRecord::Migration
  def self.up
    create_table :winers do |t|
      t.winner :entry_id

      t.timestamps
    end
  end

  def self.down
    drop_table :winers
  end
end
