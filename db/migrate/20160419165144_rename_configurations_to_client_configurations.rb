class RenameConfigurationsToClientConfigurations < ActiveRecord::Migration
  def change
    rename_table :configurations, :client_configurations
  end
end
