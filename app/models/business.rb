class Business < ActiveRecord::Base
  has_many :speed_measurements

  #def self.search_potentials(latitude, longitude, term)
    #coords = {latitude: latitude, longitude: longitude}
    #@businesses = Yelp.client.search_by_coordinates(coords, { term: name})
  #end

  def average_speed
    speed_measurements.average(:down)
  end
end
