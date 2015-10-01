# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
  
initAutoComplete: (field) ->
  field = $(field)  
  console.log(field.data('autocomplete'))
  
ready = ->
  columns = $('.column')
  maxHeight = 0
  columns.each (index, column) -> 
    height = $(column).height()
    maxHeight = height if maxHeight < height
  
  columns.height(maxHeight)
  
  $('.autocomplete').each (index, field) ->
    do ->
      field = $(field)
      field.focus( -> field.select() )
      list = field.data('autocomplete')
      field.autocomplete(delay: 10, source: list)
      
  $('.countdown').each (index, area) ->
    do ->
      area = $(area)
      endTime = new Date(area.data('time'))
      setInterval(( -> 
        delta = endTime - new Date()
        hours = delta / (60 * 60 * 1000)
        minutes = (hours % 1) * 60 
        html = []
        html.push(Math.floor(hours) + ' hours') if Math.floor(hours) > 0
        html.push(Math.floor(minutes) + ' minutes') if Math.floor(minutes) > 0
        area.html(html.join(', '))
      ), 1000)
      
    
$(document).ready(ready)
$(document).on('page:load', ready)
