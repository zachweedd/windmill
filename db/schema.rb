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

ActiveRecord::Schema.define(version: 20160420002812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "api_keys", force: :cascade do |t|
    t.string   "key",        null: false
    t.string   "notes"
    t.string   "perms",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "api_keys", ["key"], name: "index_api_keys_on_key", using: :btree

  create_table "client_configurations", force: :cascade do |t|
    t.string  "name",                   null: false
    t.string  "version",                null: false
    t.jsonb   "config_json",            null: false
    t.text    "notes"
    t.integer "configuration_group_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string   "client_key",             null: false
    t.string   "last_version"
    t.integer  "config_count"
    t.string   "last_ip"
    t.datetime "last_config_time"
    t.string   "identifier"
    t.string   "group_label"
    t.integer  "assigned_config_id"
    t.integer  "configuration_group_id"
    t.integer  "last_config_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["client_key"], name: "index_clients_on_client_key", using: :btree

  create_table "configuration_groups", force: :cascade do |t|
    t.string   "name",              null: false
    t.integer  "default_config_id"
    t.integer  "canary_config_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
