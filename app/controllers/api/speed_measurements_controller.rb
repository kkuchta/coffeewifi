class Api::SpeedMeasurementsController < Api::ApiController
  def create
    yelp_id = params.require(:business_yelp_id)
    yelp_business = YelpService.new.get(yelp_id)
    if yelp_business
      business = Business.get_from_yelp_business(yelp_business)
      if business
        SpeedMeasurement.create(speed_measurement_params)
        render text: 'ok'
      else
        render status: 500
      end
    else
      render status: 404
    end
  end

  private

  def speed_measurement_params
    params.permit(:upload, :download, :latency)
  end

end
