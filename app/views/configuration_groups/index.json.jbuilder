json.array!(@configuration_groups) do |configuration_group|
  json.extract! configuration_group, :id
  json.url configuration_group_url(configuration_group, format: :json)
end
