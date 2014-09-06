class Api::BusinessesController < ApplicationController
  def show
    #@business = Business.find(params[:id])
  end

  def search_potentials
    latitude, longitude, name =
      params.slice(:latitude, :longitude, :name).values
    @businesses = YelpService.new.search(latitude, longitude, name).first(10)
  end
end
