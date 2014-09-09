class CoffeeWifi.MeasurementModal extends CoffeeWifi.View
  template: 'measurement_modal'
  className: 'modal fade'

  events:
    'click .save-speed': 'onSaveSpeed'

  initialize: (options) ->
    @location = options.location

  render: =>
    @$el.html(JST[@template](@getTemplateData))
    $('body').append(@$el)

    super
  getTemplateData: =>
    model: @model

  afterRender: =>
    @businessSearch = new CoffeeWifi.BusinessSearchView
      el: @$('.business-search')
      location: @location
    @businessSearch.on('selectedBusiness', @businessSelected)
    @businessSearch.render()

  showModal: =>
    @$el.modal()

    # Give us some time to show the modal before we do all the speed test crap
    setTimeout @startSpeedTest, 1000

  startSpeedTest: =>
    @dfdSpeedTest = CoffeeWifi.SpeedTest.startTest()
    @dfdSpeedTest.progress @onSpeedTestProgress
    @dfdSpeedTest.done @onSpeedTestFinish

  onSpeedTestProgress: (progress) =>
    message = switch progress.type
      when  'download'
        "Pass #{progress.pass} of between 4 and 10: #{progress.percentDone} %"
      when  'upload'
        "Pass #{progress.pass} of 1: #{progress.percentDone} %"
      when  'latency'
        "#{progress.percentDone} %"
    @$(".measure-speed .#{progress.type}").text message

  onSpeedTestFinish: (results) =>
    console.log "onSpeedTestFinish"

    download = "#{results.download} mbps"
    if results.finishedEarly
      upload = "too slow to measure"
      latency = "unavailable"
    else
      upload = "#{results.upload} mbps"
      latency = "#{results.latency} ms"

    @$(".measure-speed .upload").text upload
    @$(".measure-speed .latency").text latency
    @$(".measure-speed .download").text download
    @show @$('.save-speed')

  showStep: (stepSelector) =>
    @hide @$('.step')
    @show @$('.step' + stepSelector)

  businessSelected: (business) =>
    console.log "Got business!", business
    @model = business
    @$('.display-name').text @model.get('display_name')
    @showStep '.measure-speed'

  onSaveSpeed: (e) =>
    e.preventDefault()
    @dfdSpeedTest.done (results) =>
      measurement = @model.createMeasurement(results)
      console.log "saved measurement ", measurement
      measurement.save()
