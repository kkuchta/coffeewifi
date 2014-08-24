class CoffeeWifi.View extends Backbone.View

  render: =>
    if @template
      @$el.html JST[@template]({})
    @$el

    @afterRender?()
