class CoffeeWifi.View extends Backbone.View

  render: =>
    data = @getTemplateData?() || {}
    if @template
      @$el.html JST[@template](data)
    @$el

    @afterRender?()
