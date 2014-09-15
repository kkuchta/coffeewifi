class CoffeeWifi.Business extends CoffeeWifi.Model
  @searchPotentials: (location, name) ->
    rawDfd = $.get '/api/businesses/search_potentials',
      latitude: location.latitude
      longitude: location.longitude
      name: name
    rawDfd.pipe (data) ->
      models = _.map data.businesses, (business_data) ->
        new CoffeeWifi.Business(business_data)
      new CoffeeWifi.BusinessCollection(models)

  # Create a new measurement model for this business
  createMeasurement: (result) ->
    new CoffeeWifi.SpeedMeasurement
      upload: result.upload
      download: result.download
      latency: result.latency
      business_yelp_id: @get('yelp_id')
