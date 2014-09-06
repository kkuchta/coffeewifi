class GoogleService

  # Got something weird in a yelp response
  class YelpResponseError < StandardError; end

  # Yelp address hash to lat/lon
  # Note: The api usage limit is 10 per second, so don't try to bulk geocode
  # a list of results- it won't work, and it definitely won't work at scale.
  def self.geolocate(yelp_address)
    if yelp_address.has_key? :coordinates
      {
        latitude: yelp_address.coordinates.latitude,
        longitude: yelp_address.coordinates.longitude
      }
    elsif yelp_address.has_key? :display_address
      address_string = yelp_address.display_address.join(', ')
      geocode_response = Geokit::Geocoders::GoogleGeocoder.geocode address_string

      # if geocode_response.all.size > 1, we got multiple results.  O.o
      {latitude: geocode_response.lat, longitude: geocode_response.lng}
    else
      raise GoogleService::YelpResponseError.new("missing :coordinates and :display_address for #{yelp_address}")
    end
  end
end
