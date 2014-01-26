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

ActiveRecord::Schema.define(:version => 20140125183145) do

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.string   "facebook_link"
    t.string   "youtubeteaser_link"
    t.string   "youtubecommercial_link"
    t.string   "topsy_link"
    t.integer  "seconds"
    t.integer  "spots"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "checkins", :force => true do |t|
    t.string   "likes"
    t.string   "talking"
    t.integer  "brand_id"
    t.string   "checkin_time"
    t.string   "youtube_teaser"
    t.string   "youtube_commercial"
    t.string   "sentiment_score"
    t.string   "youtube_teaser_up"
    t.string   "youtube_teaser_down"
    t.string   "youtube_commercial_up"
    t.string   "youtube_commercial_down"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
