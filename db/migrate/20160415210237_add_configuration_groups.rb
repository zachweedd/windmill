class AddConfigurationGroups < ActiveRecord::Migration
  def change
    create_table "configuration_groups" do |t|
      t.string   "name",              null: false
      t.integer  "default_config_id"
      t.integer  "canary_config_id"
      t.timestamps
    end
  end
end
