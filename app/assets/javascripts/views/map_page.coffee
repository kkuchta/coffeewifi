class CoffeeWifi.MapPageView extends CoffeeWifi.View
  template: 'map_page'

  initialize: (options) ->
    @$dfdPosition = $.Deferred()
    @getCurrentLocation()
    super

  afterRender: =>
    @$dfdPosition.done (location)=>
      @map ||= new CoffeeWifi.MapView
        el: @$('.map')
        location: location
      @map.render()

  getCurrentLocation: =>
    window
      .navigator
      .geolocation
      .getCurrentPosition(
          (pos) => @$dfdPosition.resolve pos.coords
        ,
          () => @$dfdPosition.reject arguments
      )
