class Business < ActiveRecord::Base
  has_many :speed_measurements

  def self.get_from_yelp_business(yelp_businesses)
    Business.find_or_create_by( yelp_id: yelp_businesses.id ) do |business|
      location = GoogleService.geolocate(yelp_businesses.location)
      binding.pry
      # TODO: finish this up
      #business.location = 
    end
  end

  def average_speed
    speed_measurements.average(:down)
  end
end
