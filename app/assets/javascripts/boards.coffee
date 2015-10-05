# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
  
ready = ->
  columns = $('.column')
  maxHeight = 0
  columns.each (index, column) -> 
    height = $(column).height()
    maxHeight = height if maxHeight < height
  
  columns.height(maxHeight + 420)
  
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
        
  $('.slidebutton').click ->
    closest = $(this).closest($(this).data('slideclosest'))
    toSlide = closest.find($(this).data('slidefind'))
    toSlide.toggle('slide', {direction: 'up'})
    toSlide.find('input[autofocus]').focus()

  $('.slide-hide-hide').click ->
    $(this).closest('.slide-hide').slideUp()
    
  $('.remote-update').on 'ajax:complete', (e, xhr, status) ->
    if (xhr.status == 200) 
      item = $(this).closest('.item')
      item.find($(this).data('updatefield')).html(xhr.responseText)
      $(this).closest('.slide-hide').slideUp()
    else
      alert('There was an error. Please reload the browser page.')  
      
  # $('.remote-updater').each ->
  #   do =>
  #     url = $(this).data('updaterurl')
  #     setInterval(( ->
  #       $.ajax(
  #         url: url,
  #         dataType: 'json',
  #         complete: (data) ->
  #           console.log(JSON.parse(data.responseText))
  #       )
  #     ), 3000)
    
$(document).ready(ready)
$(document).on('page:load', ready)
