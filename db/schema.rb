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

ActiveRecord::Schema.define(version: 20141210113712) do

  create_table "articles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "text",       limit: 65535
    t.integer  "user_id",    limit: 4
    t.string   "picture",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "calculations", force: :cascade do |t|
    t.string   "user_id",    limit: 255
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.integer  "inn",        limit: 4
    t.integer  "kpp",        limit: 4
    t.integer  "rs",         limit: 4
    t.string   "bank",       limit: 255
    t.string   "ks",         limit: 255
    t.integer  "bik",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "state_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "invites", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "user_to_id", limit: 4
    t.integer  "vacancy_id", limit: 4
    t.boolean  "see",        limit: 1, default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: :cascade do |t|
    t.boolean  "answer",     limit: 1
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.text     "text",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "opinions", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "user_to_id", limit: 4
    t.text     "text",       limit: 65535
    t.integer  "rate",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "pay",        limit: 4,                         default: 0
    t.decimal  "amount",               precision: 9, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",     limit: 4,                         default: 0
  end

  create_table "periods", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.date     "finish_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", force: :cascade do |t|
    t.text     "message",    limit: 65535
    t.string   "username",   limit: 255
    t.integer  "item",       limit: 4
    t.string   "table",      limit: 255
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "replies", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "user_to_id", limit: 4
    t.boolean  "see",        limit: 1, default: false
    t.integer  "vacancy_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rich_rich_images", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.string   "owner_type",         limit: 255
    t.integer  "owner_id",           limit: 4
  end

  create_table "sms_invites", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "user_to_id", limit: 4
    t.integer  "vacancy_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "country_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,                           default: "",    null: false
    t.string   "encrypted_password",     limit: 255,                           default: "",    null: false
    t.datetime "birth"
    t.string   "avatar",                 limit: 255
    t.string   "name",                   limit: 255
    t.string   "surname",                limit: 255
    t.string   "patronymic",             limit: 255
    t.boolean  "med",                    limit: 1
    t.text     "description",            limit: 65535
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,                             default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",                 limit: 255
    t.string   "facebook_url",           limit: 255
    t.string   "vk_url",                 limit: 255
    t.string   "phone",                  limit: 255
    t.integer  "uid",                    limit: 4
    t.string   "provider",               limit: 255
    t.string   "gender",                 limit: 255
    t.integer  "city_id",                limit: 4
    t.integer  "country_id",             limit: 4
    t.integer  "state_id",               limit: 4
    t.integer  "rate",                   limit: 4,                             default: 0
    t.boolean  "car",                    limit: 1,                             default: false
    t.string   "site",                   limit: 255
    t.decimal  "pocket",                               precision: 9, scale: 2, default: 0.0
    t.string   "pass",                   limit: 255
    t.boolean  "sent",                   limit: 1,                             default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vacancies", force: :cascade do |t|
    t.integer  "amount",      limit: 4
    t.integer  "city_id",     limit: 4
    t.string   "name",        limit: 255
    t.boolean  "med",         limit: 1
    t.datetime "start_date"
    t.datetime "finish_date"
    t.text     "description", limit: 65535
    t.integer  "price",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",     limit: 4
    t.integer  "country_id",  limit: 4
    t.integer  "state_id",    limit: 4
    t.boolean  "car",         limit: 1,     default: false
    t.string   "gender",      limit: 255
    t.integer  "start_age",   limit: 4
    t.integer  "finish_age",  limit: 4
  end

end
