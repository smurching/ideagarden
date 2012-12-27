# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121227040835) do

  create_table "confirmcodes", :force => true do |t|
    t.string   "code"
    t.string   "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "idea_posting_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "body"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "help"
    t.boolean  "private"
    t.integer  "reply_id"
    t.integer  "feedback_id"
  end

  create_table "followers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "follower_user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "followings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "followed_user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "idea_postings", :force => true do |t|
    t.string   "name"
    t.string   "pitch"
    t.text     "description"
    t.datetime "published_at"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "potential"
    t.boolean  "IsOwner",      :default => false
    t.integer  "OwnerID",      :default => -1
  end

  create_table "idea_postings_users", :id => false, :force => true do |t|
    t.integer "idea_posting_id"
    t.integer "user_id"
  end

  create_table "join_requests_mades", :force => true do |t|
    t.integer  "idea_posting_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
  end

  create_table "joinrequests", :force => true do |t|
    t.integer  "userid"
    t.string   "message"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "idea_posting_id"
  end

  create_table "private_messages", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "bio"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reset_codes", :force => true do |t|
    t.integer  "user_id"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tags", :force => true do |t|
    t.integer  "idea_posting_id"
    t.string   "value"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "password_digest"
    t.string   "password_hash"
    t.string   "confirmation_code"
    t.boolean  "confirmed"
    t.text     "confirm_code"
    t.string   "reset_code"
    t.datetime "reset_code_timestamp"
    t.boolean  "admin",                :default => false
    t.boolean  "teacher",              :default => false
  end

end
