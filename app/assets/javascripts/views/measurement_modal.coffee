class CoffeeWifi.MeasurementModal extends CoffeeWifi.View
  template: 'measurement_modal'
  className: 'modal fade'

  initialize: (options) ->
    @location = options.location

  render: =>
    @$el.html(JST[@template]())
    $('body').append(@$el)

    super

  afterRender: =>
    @businessSearch = new CoffeeWifi.BusinessSearchView
      el: @$('.business-search')
      location: @location
    @businessSearch.on('selectedBusiness', @businessSelected)
    @businessSearch.render()

  showModal: =>
    @$el.modal()

  #showStep: (stepSelector) =>
    #@$('.step').hide()
    #@$('.step ' + stepSelector).show()

  businessSelected: (business) ->
    console.log "Got business!", business
