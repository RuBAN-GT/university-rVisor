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

ActiveRecord::Schema.define(version: 20160514151556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "result_clicks", force: :cascade do |t|
    t.integer  "result_id"
    t.integer  "x"
    t.integer  "y"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "result_clicks", ["result_id"], name: "index_result_clicks_on_result_id", using: :btree

  create_table "result_comments", force: :cascade do |t|
    t.integer  "result_id"
    t.integer  "x",                             null: false
    t.integer  "y",                             null: false
    t.string   "color",      default: "yellow", null: false
    t.string   "comment",                       null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "result_comments", ["result_id"], name: "index_result_comments_on_result_id", using: :btree

  create_table "results", force: :cascade do |t|
    t.integer  "test_id"
    t.integer  "user_id"
    t.integer  "time_cont",    default: 0, null: false
    t.text     "main_comment"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "results", ["test_id"], name: "index_results_on_test_id", using: :btree
  add_index "results", ["user_id"], name: "index_results_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "screens", force: :cascade do |t|
    t.integer  "test_id"
    t.string   "image",                  null: false
    t.string   "comment"
    t.integer  "order",      default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "screens", ["test_id"], name: "index_screens_on_test_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "title",       null: false
    t.string   "info"
    t.string   "private_key", null: false
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "services", ["private_key"], name: "index_services_on_private_key", unique: true, using: :btree
  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

  create_table "tests", force: :cascade do |t|
    t.integer  "service_id"
    t.integer  "user_id"
    t.string   "title",                           null: false
    t.string   "info"
    t.text     "description"
    t.string   "status",      default: "opinion", null: false
    t.string   "time_status", default: "free",    null: false
    t.integer  "time_limit",  default: 0,         null: false
    t.string   "public_key",                      null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "tests", ["public_key"], name: "index_tests_on_public_key", unique: true, using: :btree
  add_index "tests", ["service_id"], name: "index_tests_on_service_id", using: :btree
  add_index "tests", ["user_id"], name: "index_tests_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name",                                null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
  end

  add_foreign_key "result_clicks", "results"
  add_foreign_key "result_comments", "results"
  add_foreign_key "results", "tests"
  add_foreign_key "results", "users"
  add_foreign_key "screens", "tests"
  add_foreign_key "services", "users"
  add_foreign_key "tests", "services"
  add_foreign_key "tests", "users"
end
