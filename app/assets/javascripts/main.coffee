ready = ->
  # main menu popup
  $('.main.menu .browse.item').on 'click', (e) ->
    e.preventDefault()
  $('.main.menu .browse.item').popup
    popup: $('.main.menu .browser.popup'),
    position: 'bottom left',
    on: 'click',
    inline: true,
    lastResort: 'bottom left',
    prefer: 'opposite',
    onShow: ->
      $('.main.menu .browse.item').addClass('active')
    onHide: ->
      $('.main.menu .browse.item').removeClass('active')

$(document).ready(ready)
$(document).on('page:load', ready)
