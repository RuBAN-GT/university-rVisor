ready = ->
  $("#area img.screenshot").click (e) ->
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

    $("#area form").append('<input type="hidden" name="passage[clicks][]" value="' + X + ',' + Y + '" />')

    $("#logs").val($("#logs").val() + '[' + X + ',' + Y + '];')

$(document).ready ready
$(document).on "page:load", ready