json.ignore_nil!
json.businesses do
  json.array! @businesses do |business|
    json.partial! "api/businesses/business", business: business
  end
end
