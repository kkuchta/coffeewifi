class Business < ActiveRecord::Base
  has_many :speed_measurements

  def self.get_from_yelp_business(yelp_business)
    Business.find_or_create_by( yelp_id: yelp_business.id ) do |business|
      location = GoogleService.geolocate(yelp_business.location)
      business.latitude = location[:latitude]
      business.longitude = location[:longitude]
      business.display_name = yelp_business.name
    end
  end

  def average_speed
    speed_measurements.average(:down) || 0
  end
end
