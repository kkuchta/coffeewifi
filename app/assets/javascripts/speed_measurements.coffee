# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  navigator.geolocation.getCurrentPosition(onGetPosition, onErrorPosition)
  setUpControls()

setUpControls = ->
  $('#location-search').submit onLocationSearchSubmit
  $('#final-form').submit onFinalSubmit

onLocationSearchSubmit = (e)->
  e.preventDefault()
  query = $('#location-search .query').val()
  params =
    lat: window.coords.latitude
    lon: window.coords.longitude
    query: query
  $dfdGet = $.get('/speed_measurements/search_location', params)
  $dfdGet.done (results) ->
    $ul = $('#search-results')
    for result in results
      $li = $('<li class="result">')
      $li.data id: result.id
      $li.text result.name
      $li.click(onResultClick)
      $ul.append $li

onFinalSubmit = (e) ->
  e.preventDefault()
  $form = $('#final-form')
  params =
    speed_measurement:
      business_id: window.selectedId
      up: $form.find('.up').val()
      down: $form.find('.down').val()
  $.post('/speed_measurements', params)

onResultClick = (e) ->
  $result = $(e.target)
  $('#search-results').hide()
  window.selectedId = $result.data('id')
  $('#selected-business').text("Selected #{selectedId}").show()
  $('#final-form').show()

onGetPosition = (position)->
  console.log "position = ", position
  $('.content').show()
  $('.spinner').hide()
  window.coords = position.coords

onErrorPosition = ->
  $('.spinner').hide()
  $('.no-geo').show()
  console.log "zomg errz:", arguments
