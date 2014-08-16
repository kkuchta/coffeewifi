class Business < ActiveRecord::Base
  has_many :speed_measurements
  def average_speed
    speed_measurements.average(:down)
  end
end
