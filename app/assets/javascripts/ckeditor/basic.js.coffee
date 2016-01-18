#= require ckeditor/init

ready = ->
  if CKEDITOR != undefined
    for name of CKEDITOR.instances
      try
        CKEDITOR.replace name
      catch e
        continue

$(document).on "page:load", ready