class YelpService
  def search(latitude, longitude, term)
    coords = {latitude: latitude, longitude: longitude}
    yelp_businesses = Yelp.client.search_by_coordinates(coords, { term: term})
    yelp_businesses.businesses.map{|b| build_potential_business(b)}.compact
  end

  private

  # Returns nil on unusable result
  def build_potential_business(yelp_result)
    if yelp_result.is_closed
      return nil
    end

    business_params = {
      yelp_id: yelp_result.id,
      display_name: yelp_result.name
    }

    Business.new(business_params)
  end
end
