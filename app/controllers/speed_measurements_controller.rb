class SpeedMeasurementsController < ApplicationController
  before_action :set_speed_measurement, only: [:show, :edit, :update, :destroy]

  def search_location
    lat = params[:lat]
    lon = params[:lon]
    query = params[:query]
    coords = {latitude: lat, longitude: lon}
    @search_results = Yelp.client.search_by_coordinates(coords, { term: query})
    binding.pry
  end

  # GET /speed_measurements/1
  # GET /speed_measurements/1.json
  def show
  end

  # GET /speed_measurements/new
  def new
    @speed_measurement = SpeedMeasurement.new
  end

  # POST /speed_measurements
  # POST /speed_measurements.json
  def create
    @speed_measurement = SpeedMeasurement.new(speed_measurement_params)

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
      params.require(:speed_measurement).permit(:up, :down, :business_id)
    end
end
