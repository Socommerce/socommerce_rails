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

ActiveRecord::Schema.define(version: 20170507020440) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "order_items", force: :cascade do |t|
    t.string   "name"
    t.string   "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "order_item_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "movie_name"
    t.string   "theatre_name"
    t.string   "no_of_seats"
    t.string   "time"
  end

  create_table "tenants", force: :cascade do |t|
    t.string   "name"
    t.string   "subdomain"
    t.string   "company_email"
    t.string   "company_phone"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "password"
    t.string   "confirm_password"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "twitter_id"
    t.string   "name"
    t.string   "token"
    t.string   "secret"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
