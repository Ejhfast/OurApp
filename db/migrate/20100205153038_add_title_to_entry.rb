class AddTitleToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :title, :string
  end

  def self.down
    remove_column :entries, :title, :string
  end
end
