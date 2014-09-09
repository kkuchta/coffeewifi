class CoffeeWifi.View extends Backbone.View

  render: =>
    data = @getTemplateData?() || {}
    if @template
      @$el.html JST[@template](data)
    @$el

    @afterRender?()

  # $el.hide() and .show() don't work on elements with .hidden or .show on them
  # because bootstrap uses !important on those.
  hide: ($el = null) =>
    $el ||= @$el
    $el.removeClass('show')
    $el.hide()
  show: ($el = null) =>
    $el ||= @$el
    $el.removeClass('hidden')
    $el.show()
