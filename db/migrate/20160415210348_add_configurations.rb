class AddConfigurations < ActiveRecord::Migration
  def change
    create_table "configurations" do |t|
      t.string  "name",    null: false
      t.integer "version", null: false
      t.jsonb   "config_json", null: false
      t.text    "notes"
      t.integer "configuration_group_id"
    end
  end
end
