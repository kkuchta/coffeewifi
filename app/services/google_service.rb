class GoogleService
  # Yelp address hash to lat/lon
  def self.geolocate(yelp_address)
    if yelp_address[:coordinates]
      {
        lat: yelp_address[:coordinates][:latitude],
        lon: yelp_address[:coordinates][:longitude]
      }
    else
      address_string = yelp_address[:display_address].join(', ')
      geocode_response = Geokit::Geocoders::GoogleGeocoder.geocode address_string
      # if geocode_response.all.size > 1, we got multiple results.  O.o
      {lat: geocode_response.lat, lon: geocode_response.lng}
    end
  end
end
