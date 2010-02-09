# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100206024152) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "entry_id"
    t.integer  "request_id"
    t.integer  "parent_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "entries", :force => true do |t|
    t.integer  "user_id"
    t.integer  "request_id"
    t.integer  "flags"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "submission_file_name"
    t.string   "submission_content_type"
    t.integer  "submission_file_size"
    t.datetime "submission_updated_at"
  end

  create_table "requests", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "category_id"
    t.integer  "user_id"
    t.integer  "karma"
    t.date     "start"
    t.date     "end"
    t.boolean  "open"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "karma_current",                            :default => 20
    t.integer  "karma_total",                              :default => 20
    t.boolean  "admin"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "winners", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entry_id"
  end

end
