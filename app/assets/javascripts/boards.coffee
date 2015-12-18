# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
  
updateInterval = false  
setUpdateInterval = (url) ->
  clearInterval(updateInterval) if updateInterval
  
  lastUpdateAt = new Date().getTime() unless lastUpdateAt 
  updateSelect = $('.auto-update-select')[0]  
  intervalOptions = [5, 10, 30, 60, 300, (60 * 60), (60 * 60 * 24), -1]
  interval = intervalOptions[updateSelect.selectedIndex]
  return if interval <= 0

  url = $('.board-update').data('updaterurl')
  updateInterval = setInterval(( ->
    $.ajax(
      url: "#{url}?time=#{lastUpdateAt}",
      dataType: 'json',
      complete: (data) ->
        if (data.responseText.length)
          lastUpdateAt = new Date().getTime()
          info = JSON.parse(data.responseText)
          items = $(info.items)
          items.each (index, item) ->
            foundItem = $("#item-#{item.id}")
            if (foundItem.length)
              foundItem.find('.title-info').html(item.title)
              foundItem.find('.vote-info').html(item.vote_html)
              foundItem.find('.comment-info').html(item.comment_html)
              foundItem.find('.inner').effect('highlight', {}, 3000)
            else 
              column = $(".#{item.column_name} .items")
              column.prepend(item.html)
              column.find("#item-#{item.id} .inner").effect('highlight', {}, 3000)
          $('.contributors').html(info.contributors)
        else
          delay = 1000 * interval * 3
          delay = (1000 * 60 * 30) if delay < (1000 * 60 * 30)
          if ((new Date().getTime() - lastUpdateAt) > delay)
            updateSelect.selectedIndex = updateSelect.selectedIndex + 1
            interval = intervalOptions[updateSelect.selectedIndex]
            
    )
  ), interval * 1000)
  
addItems = (column, items) ->
  container = document.createElement('DIV')
  for item in items
    container.prepend(item.html)
  container.slideUp()
  
  
ready = ->
  columns = $('.column')
  maxHeight = 0
  columns.each (index, column) -> 
    height = $(column).height()
    maxHeight = height if maxHeight < height
  
  columns.height(maxHeight + 150)
  
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
      
  $('.auto-update-select').change -> setUpdateInterval()    
  $('.board-update').each -> setUpdateInterval()
    
$(document).ready(ready)
$(document).on('page:load', ready)
