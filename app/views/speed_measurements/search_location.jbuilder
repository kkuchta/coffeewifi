json.array! @search_results.businesses do |business|
  json.name business.name
  json.id business.id
end
