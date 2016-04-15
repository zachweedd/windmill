class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string "key", null: false
      t.string "notes"
      t.string "perms", null: false
      t.timestamps
    end

    add_index "api_keys", ["key"], name: "index_api_keys_on_key"
  end
end
