class YelpService
  def search(latitude, longitude, term)
    coords = {latitude: latitude, longitude: longitude}
    yelp_businesses = Yelp.client.search_by_coordinates(coords, { term: term})
    yelp_businesses.businesses.map{|b| build_potential_business(b)}.compact
  end

  # TODO: cache recently found yelp business during search so they can be reused
  # here.
  def get(yelp_id)
    begin
      return Yelp.client.business(yelp_id)
    rescue JSON::ParserError => e

      # The yelp gem apparently doesn't handle a missing business at all.  The 
      # yelp api returns an html error page, and the gem fails to handle it.  So
      # the only way for *me* to handle it is to catch a JSON::ParserError.
      #
      # ┌∩┐(ಠ_ಠ)┌∩┐
      #
      return nil
    end
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
