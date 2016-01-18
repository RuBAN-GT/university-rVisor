ready = ->
  $(".ui.left.sidebar").sidebar("setting", "transition", "overlay").sidebar "attach events", ".toc.default.item", "overlay"
  $(".ui.right.sidebar").sidebar("setting", "transition", "overlay").sidebar "attach events", ".toc.user"

$(document).ready ready
$(document).on "page:load", ready