json.client_configuration do
  json.(@client_configuration, :id, :name, :version, :notes, :config_json)
  json.assigned_endpoints @client_configuration.assigned_clients.map {|e| e.id}
  json.assigned_endpoints_count @client_configuration.assigned_clients.count
  json.configured_endpoints @client_configuration.configured_clients.map {|e| e.id}
  json.configured_endpoints_count @client_configuration.configured_clients.count
end
