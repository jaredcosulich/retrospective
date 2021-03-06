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

ActiveRecord::Schema.define(version: 20151015010903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.string   "good_column_name"
    t.string   "bad_column_name"
    t.string   "meh_column_name"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.datetime "close_at"
    t.string   "name"
    t.string   "password"
    t.string   "slug"
    t.integer  "group_id"
    t.string   "good_column_description"
    t.string   "meh_column_description"
    t.string   "bad_column_description"
  end

  add_index "boards", ["slug"], name: "index_boards_on_slug", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "comment"
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "comments", ["slug"], name: "index_comments_on_slug", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "parent_group_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "slug"
  end

  create_table "items", force: :cascade do |t|
    t.string   "column_name"
    t.integer  "board_id"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "title"
    t.string   "slug"
    t.integer  "votes_count",    default: 0
    t.integer  "comments_count", default: 0
  end

  add_index "items", ["slug"], name: "index_items_on_slug", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "votes", ["slug"], name: "index_votes_on_slug", using: :btree

end
