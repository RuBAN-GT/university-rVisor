ready = ->
  $('.research.segment .vote').click ->
    if $(this).is('.voted')
      $(this).removeClass 'voted'
      $(this).removeClass 'positive'
      $('#research.form input[value="' + $(this).attr('data-screen') + '"]').remove()
    else
      $(this).addClass 'voted'
      $(this).addClass 'positive'

      $('#research.form').append '<input type="hidden" name="result[poll][]" value=' + $(this).attr('data-screen') + ' />'

  $('.research.segment .clicked img').click (e) ->
    $('.research.segment .clicked').append '<div class="click point" style="top: ' + (e.pageY - $(this).offset().top) + 'px; left: ' + (e.pageX - $(this).offset().left) + 'px"></div>'

    X = ((e.pageX - $(this).offset().left) / this.width).toFixed(3)
    Y = ((e.pageY - $(this).offset().top) / this.height).toFixed(3)

    if(X < 0)
      X = 0
    else if(X > 1)
      x = 1
    if(Y < 0)
      Y = 0
    else if(Y > 1)
      Y = 1

    $('#research.form').append('<input type="hidden" name="result[clicks][]" value="' + X + ',' + Y + '" />')

$(document).ready(ready)
$(document).on('page:load', ready)
