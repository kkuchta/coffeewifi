class CoffeeWifi.Navbar extends CoffeeWifi.View
  template: 'navbar'
  events:
    'click .submit-your-coffeeshop': 'onClickSubmitYourCoffeeshop'

  initialize: (options) ->
    @location = options.location
    super

  onClickSubmitYourCoffeeshop: =>
    console.log "clicked1"
    @modal ||= new CoffeeWifi.MeasurementModal(location: @location)
    @modal.render()
    @modal.showModal()
    console.log "clicked"
