class CoffeeWifi.BusinessSearchView extends CoffeeWifi.View
  template: 'business_search'
  businessRowTemplate: 'business_search_row'

  events:
    'submit form': 'onBusinessSearchSubmit'
    'click .business-search-row': 'onRowClick'

  initialize: (options) ->
    @location = options.location

  onBusinessSearchSubmit: (e) =>
    e.preventDefault()

    name = @$('form .business-name').val()
    unless name.length
      return

    @showSpinner()
    searchDfd = CoffeeWifi.Business.searchPotentials(@location, name)
    @$('input, button').prop('disabled', true)
    searchDfd.done (businesses) =>
      console.log "Done!", businesses
      @collection = businesses
      #@populateBusinessList(businesses)
      #@$('.business-list').show()
      @render()
    searchDfd.fail ->
      console.log "Fail!", arguments
    searchDfd.always =>
      @hideSpinner()

  onRowClick: (e) =>
    e.preventDefault()
    $row = $(e.target).closest('li')
    yelpId = $row.data('yelpId')
    @$('.business-list').find('li').not($row).hide()
    business = this.collection.findWhere({yelp_id: yelpId})
    @trigger('selectedBusiness', business)

  getTemplateData: =>
    placeholderShops: [
      'Bean There'
      'Cafe du Soleil'
      'Bauhaus Coffee'
      'Dogpatch Cafe'
      'Bread and Cocoa'
    ],
    collection: @collection

  showSpinner: =>
    @spinner ?= new Spinner()
    @spinner.spin(@$('.spinner').get()[0])

  hideSpinner: =>
    @spinner.stop()

  populateBusinessList: (businesses) =>
    $list = @$('.business-list').empty()
    _.each businesses, (business) =>
      $list.append $(JST[@businessRowTemplate](business.attributes))
