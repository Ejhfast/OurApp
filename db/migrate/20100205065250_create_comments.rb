class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :title
      t.text :body
      t.integer :entry_id
      t.integer :request_id
      t.integer :parent_comment

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
