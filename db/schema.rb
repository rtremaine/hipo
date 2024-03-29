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

ActiveRecord::Schema.define(:version => 20120515021620) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contacts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "created_by"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "confirmed",  :default => false
    t.integer  "company_id"
  end

  create_table "dentists", :force => true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "middle"
    t.string   "address1"
    t.string   "address2"
    t.integer  "user_id"
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
    t.integer  "company_id"
    t.string   "fax"
  end

  create_table "patients", :force => true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "ssn"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "company_id"
  end

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "record_sets", :force => true do |t|
    t.integer  "patient_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.integer  "status"
  end

  create_table "records", :force => true do |t|
    t.integer  "patient_id"
    t.string   "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "record"
    t.integer  "record_set_id"
  end

  create_table "shares", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "record_set_id"
    t.datetime "received_date"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.datetime "emailed_date"
    t.text     "comment"
  end

  create_table "sharing_modes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "plan_id"
    t.datetime "current_period_end"
    t.datetime "current_period_start"
    t.string   "status"
    t.datetime "trial_end"
    t.datetime "trial_start"
    t.string   "stripe_card_token"
    t.string   "stripe_customer_token"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.integer  "company_id"
    t.string   "stripe_customer_token"
    t.boolean  "is_admin",                              :default => false
    t.string   "name"
    t.integer  "sharing_mode_id",                       :default => 1
    t.string   "authentication_token"
    t.string   "company_name"
    t.integer  "invited_by_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
