ready = ->
  $(".ui.browse").popup
    inline   : true
    hoverable: true

$(document).ready ready
$(document).on "page:load", ready