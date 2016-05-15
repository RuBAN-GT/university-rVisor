ready = ->
  # overlay settings
  $('body').dimmer
    duration:
      show: 500,
      hide: 800

  # tabs
  $('.tabs .item').tab()

  # datepicker
  $('.datepicker').daterangepicker
    singleDatePicker: true
    showDropdowns: true,
    format: 'YYYY-MM-DD'

  # close messages
  $('#messages').on 'click', '.message .close', ->
    $(this).closest('.message').transition
      animation: 'fade',
      onComplete: ->
        $(this).remove()

  # checkbox
  $('.ui.checkbox').checkbox()

  # rating & form usage
  $('.ui.rating').rating('disable')
  $('form .ui.rating').rating
    maxRating: 5,
    clearable: true,
    onRate: (value) ->
      if Number.isInteger(value) && value >= 0 && value <= 5
        if $(this).data('rating-init') == undefined
          $(this).attr('data-rating-init', true)
        else
          name = $(this).attr('name')

          if name != undefined
            $(this).parents('form').find('input[name="' + name + '"]').remove()
            $(this).parents('form').append('<input type="hidden" name="' + name + '" value="' + value + '" />')

  # beautiful dropdown
  $('.ui.dropdown:not(.monthselect,.yearselect)').dropdown()

  # progress bar
  $('.ui.progress').progress
    total: 3

$(document).ready(ready)
$(document).on('page:load', ready)
