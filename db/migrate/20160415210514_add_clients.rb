class AddClients < ActiveRecord::Migration
  def change
    create_table "clients", force: :cascade do |t|
      t.string   "node_key",               null: false
      t.string   "last_version"
      t.integer  "config_count"
      t.string   "last_ip"
      t.datetime "last_config_time"
      t.string   "identifier"
      t.string   "group_label"
      t.integer  "assigned_config_id"
      t.integer  "configuration_group_id"
      t.integer  "last_config_id"
      t.timestamps
    end

    add_index "clients", ["node_key"], name: "index_clients_on_node_key"
  end
end
