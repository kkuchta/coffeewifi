class Api::SpeedMeasurementsController < Api::ApiController
  def create
    yelp_id = params.require(:business_yelp_id)
    yelp_business = YelpService.new.get(yelp_id)
    if yelp_business
      Business.get_from_yelp_business(yelp_business)
      speed_measurement_params
    else
      render status: 404
    end
  end

  private

  def speed_measurement_params
    params.permit(:up, :down, :latency, :business_yelp_id)
  end

end
