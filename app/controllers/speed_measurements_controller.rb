class SpeedMeasurementsController < ApplicationController
  before_action :set_speed_measurement, only: [:show, :edit, :update, :destroy]

  def search_location
    lat = params[:lat]
    lon = params[:lon]
    query = params[:query]
    coords = {latitude: lat, longitude: lon}
    @search_results = Yelp.client.search_by_coordinates(coords, { term: query})
  end

  # GET /speed_measurements/1
  # GET /speed_measurements/1.json
  def show
  end

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

  # GET /speed_measurements/new
  def new
    @speed_measurement = SpeedMeasurement.new
  end

  def create
    business_yelp_id = speed_measurement_params[:business_id]
    business = Business.find_by_yelp_id(business_yelp_id)
    unless business
      location = speed_measurement_params[:business_location]
      lat_lon = GoogleService.geolocate(location)
      business = Business.create( yelp_id: business_yelp_id, lat: lat_lon[:lat], lon: lat_lon[:lon] )
    end
    creation_params = speed_measurement_params.slice(:business, :up, :down)
    creation_params[:business] = business
    @speed_measurement = SpeedMeasurement.new(creation_params)

    respond_to do |format|
      if @speed_measurement.save
        format.html { redirect_to @speed_measurement, notice: 'Speed measurement was successfully created.' }
        format.json { render :show, status: :created, location: @speed_measurement }
      else
        format.html { render :new }
        format.json { render json: @speed_measurement.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_speed_measurement
      @speed_measurement = SpeedMeasurement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def speed_measurement_params

      #fuckit, to lazy to deal with permit crap right now
      ActionController::Parameters.permit_all_parameters = true

      params[:speed_measurement]
    end
end
