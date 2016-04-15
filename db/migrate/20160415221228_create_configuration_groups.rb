class CreateConfigurationGroups < ActiveRecord::Migration
  def change
    create_table :configuration_groups do |t|

      t.timestamps null: false
    end
  end
end
