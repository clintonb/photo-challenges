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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140326204627) do

  create_table "challenges", force: true do |t|
    t.string   "description", null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "challenges", ["user_id"], name: "index_challenges_on_user_id"

  create_table "challenges_photos", force: true do |t|
    t.integer "challenge_id"
    t.integer "photo_id"
  end

  add_index "challenges_photos", ["challenge_id", "photo_id"], name: "index_challenges_photos_on_challenge_id_and_photo_id", unique: true
  add_index "challenges_photos", ["challenge_id"], name: "index_challenges_photos_on_challenge_id"
  add_index "challenges_photos", ["photo_id"], name: "index_challenges_photos_on_photo_id"

  create_table "daily_challenges", force: true do |t|
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "daily_challenges", ["challenge_id"], name: "index_daily_challenges_on_challenge_id"

  create_table "data_sources", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "data_sources", ["name"], name: "index_data_sources_on_name", unique: true

  create_table "photos", force: true do |t|
    t.integer  "user_id",                 null: false
    t.string   "url",                     null: false
    t.integer  "data_source_id",          null: false
    t.string   "data_source_external_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["data_source_id", "data_source_external_id"], name: "index_photos_on_data_source_id_and_data_source_external_id", unique: true
  add_index "photos", ["data_source_id"], name: "index_photos_on_data_source_id"
  add_index "photos", ["user_id"], name: "index_photos_on_user_id"

  create_table "users", force: true do |t|
    t.string   "first_name",             default: "", null: false
    t.string   "last_name"
    t.string   "display_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["twitter_id"], name: "index_users_on_twitter_id", unique: true

end
