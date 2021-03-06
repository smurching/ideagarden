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

ActiveRecord::Schema.define(:version => 20130915053118) do

  create_table "confirmcodes", :force => true do |t|
    t.string   "code"
    t.string   "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "feedback_votes", :force => true do |t|
    t.integer  "feedback_id"
    t.integer  "user_id"
    t.boolean  "is_upvote"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "idea_posting_id"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "private"
    t.integer  "feedback_id"
    t.text     "body"
    t.integer  "help",            :default => 0
    t.boolean  "topic",           :default => false
    t.string   "title"
    t.integer  "root_id"
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
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "potential",          :default => 0
    t.string   "opengraph_id"
    t.boolean  "state",              :default => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.float    "featured_rating",    :default => 0.0
    t.integer  "featured_count",     :default => 0
    t.boolean  "featured",           :default => false
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
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "idea_posting_id"
    t.text     "message"
  end

  create_table "private_messages", :force => true do |t|
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.text     "body"
    t.integer  "user_id"
    t.boolean  "active",       :default => true
    t.integer  "recipient_id"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "bio"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "recent_votes", :force => true do |t|
    t.integer  "idea_posting_id"
    t.boolean  "is_upvote"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "recipients", :force => true do |t|
    t.integer  "user_id"
    t.integer  "private_message_id"
    t.boolean  "active"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "reset_codes", :force => true do |t|
    t.integer  "user_id"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "senders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "private_message_id"
    t.boolean  "active"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tags_lists", :force => true do |t|
    t.integer  "idea_posting_id"
    t.boolean  "technology"
    t.boolean  "science_and_math"
    t.boolean  "art"
    t.boolean  "language"
    t.boolean  "community_service"
    t.boolean  "making_things"
    t.boolean  "research"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "password_hash"
    t.string   "reset_code"
    t.datetime "reset_code_timestamp"
    t.boolean  "admin",                :default => false
    t.boolean  "teacher",              :default => false
    t.string   "confirmation_code"
    t.string   "posting_votes"
    t.boolean  "confirmed",            :default => false
    t.boolean  "facebook",             :default => false
    t.string   "access_token"
    t.string   "facebook_id"
    t.string   "confirm_code"
  end

end
