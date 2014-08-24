class HomeController < ApplicationController
  CONSTRUCTION_IMAGE_COUNT = 9

  def index
    businesses = Business.all.map do |business|
      speed =
        if business.average_speed > 20
          3
        elsif business.average_speed > 10
          2
        else
          1
        end
      {
        lat: business.lat,
        lon: business.lon,
        id: business.id,
        yelp_id: business.yelp_id,
        speed: speed
      }
    end
    gon.businesses = businesses
  end

end
