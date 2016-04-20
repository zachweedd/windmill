class ChangeClientConfigurationVersionToString < ActiveRecord::Migration
  def change
    change_column :client_configurations, :version, :string
  end
end
