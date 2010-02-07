class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.string :title
      t.text :description
      t.integer :category_id
      t.integer :user_id
      t.integer :karma
      t.datetime :start
      t.datetime :end
      t.boolean :open

      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
