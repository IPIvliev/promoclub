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

ActiveRecord::Schema.define(:version => 20141210113712) do

  create_table 'articles', :force => true do |t|
    t.string   "name"
    t.text     "text"
    t.integer  "user_id"
    t.string   "picture"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "calculations", :force => true do |t|
    t.string   "user_id"
    t.string   "name"
    t.string   "address"
    t.integer  "inn"
    t.integer  "kpp"
    t.integer  "rs"
    t.string   "bank"
    t.string   "ks"
    t.integer  "bik"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "invites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "user_to_id"
    t.integer  "vacancy_id"
    t.boolean  "see",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "messages", :force => true do |t|
    t.boolean  "answer"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "text",       :limit => 255
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "opinions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "user_to_id"
    t.text     "text"
    t.integer  "rate"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "pay",                                      :default => 0
    t.decimal  "amount",     :precision => 9, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.integer  "status",                                   :default => 0
  end

  create_table "periods", :force => true do |t|
    t.integer  "user_id"
    t.date     "finish_date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "replies", :force => true do |t|
    t.integer  "user_id"
    t.integer  "user_to_id"
    t.boolean  "see",        :default => false
    t.integer  "vacancy_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "rich_rich_files", :force => true do |t|
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "rich_file_file_name"
    t.string   "rich_file_content_type"
    t.integer  "rich_file_file_size"
    t.datetime "rich_file_updated_at"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.text     "uri_cache"
    t.string   "simplified_type",        :default => "file"
  end

  create_table "sms_invites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "user_to_id"
    t.integer  "vacancy_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                                :default => "",    :null => false
    t.string   "encrypted_password",                                   :default => "",    :null => false
    t.datetime "birth"
    t.string   "avatar"
    t.string   "name"
    t.string   "surname"
    t.string   "patronymic"
    t.boolean  "med"
    t.text     "description"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                        :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
    t.string   "status"
    t.string   "facebook_url"
    t.string   "vk_url"
    t.string   "phone"
    t.integer  "uid"
    t.string   "provider"
    t.string   "gender"
    t.integer  "city_id"
    t.integer  "country_id"
    t.integer  "state_id"
    t.integer  "rate",                                                 :default => 0
    t.boolean  "car",                                                  :default => false
    t.string   "site"
    t.decimal  "pocket",                 :precision => 9, :scale => 2, :default => 0.0
    t.string   "pass"
    t.boolean  "sent",                                                 :default => true
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vacancies", :force => true do |t|
    t.integer  "amount"
    t.integer  "city_id"
    t.string   "name"
    t.boolean  "med"
    t.datetime "start_date"
    t.datetime "finish_date"
    t.text     "description"
    t.integer  "price"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "user_id"
    t.integer  "country_id"
    t.integer  "state_id"
    t.boolean  "car",         :default => false
    t.string   "gender"
    t.integer  "start_age"
    t.integer  "finish_age"
  end

end
