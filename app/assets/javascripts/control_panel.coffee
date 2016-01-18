ready = ->
  # sidebar functions
  $("#sidebar").sidebar("setting", "transition", "overlay").sidebar("attach events", ".toc.default.item", "overlay")

  # remote uploading
  $('form').on "ajax:remotipartComplete", (e, data) ->
    console.log(e, data)

$(document).ready ready
$(document).on "page:load", ready