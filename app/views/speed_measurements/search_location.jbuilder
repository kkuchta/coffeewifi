json.array! @search_results.businesses do |business|
  json.name business.name
  json.id business.id
  json.location JSON.parse(business.location.to_json)
end
