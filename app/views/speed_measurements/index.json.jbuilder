json.array!(@speed_measurements) do |speed_measurement|
  json.extract! speed_measurement, :id, :up, :down
  json.url speed_measurement_url(speed_measurement, format: :json)
end
