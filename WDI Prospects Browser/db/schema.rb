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

ActiveRecord::Schema.define(:version => 20140208025330) do

  create_table "change_histories", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "change"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "wdi_prospects", :force => true do |t|
    t.string   "e_i_n"
    t.string   "name"
    t.string   "in_care_of_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.float    "asset_amount"
    t.float    "income_amount"
    t.float    "form_990_revenue_amount"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "wdi_refined_prospects", :force => true do |t|
    t.integer  "e_i_n"
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.float    "income_amount"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "title"
    t.boolean  "has_donation_button"
    t.string   "website"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

end
