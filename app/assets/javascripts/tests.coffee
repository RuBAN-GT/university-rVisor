ready = ->
  @file_size = 6

  $('#test_status').change ->
    if this.value == 'clicks'
      @file_size = 1

      $('#uploader').attr 'multiple', false

      if $('.upload.field .cards .card').size() > 0
        $('.upload.field .ui.file input').attr 'disabled', true
        $('.upload.field .ui.file .button').addClass 'disabled'
    else
      @file_size = 6

      $('#uploader').attr 'multiple', true

      $('.upload.field .ui.file input').attr 'disabled', false
      $('.upload.field .ui.file .button').removeClass 'disabled'

  $('#uploader').fileupload(
    {
      sequentialUploads: true,
      url: '/screens.js',
      maxNumberOfFiles: @file_size,
      type: 'POST',
      progressInterval: 50
    }
  )

  $('#uploader').bind 'fileuploadchunksend', (e, data) ->
    console.log data
  $('#uploader').bind 'fileuploadstart', (e, data) ->
    $('.upload.field .ui.file input').attr 'disabled', true
    $('.upload.field .ui.file .button').addClass 'disabled'

    $('.upload.field .ui.file').after '<div id="progress" class="ui progress" data-value="0" data-total="100"><div class="bar"><div class="progress"></div></div></div>'


  $('#uploader').bind 'fileuploadprogress', (e, data) ->
    progress = parseInt(data.loaded / data.total * 100, 10);

    if progress > 80
      progress = 80

    $('#progress').progress
      value: progress

  $('#uploader').bind 'fileuploaddone', (e, data) ->
    $('#progress').progress
      value: 100

    $('#progress').addClass('green').fadeOut 700, ->
      $('#progress').remove()

      if $('#test_status').val() != 'clicks'
        $('.upload.field .ui.file input').attr 'disabled', false
        $('.upload.field .ui.file .button').removeClass 'disabled'

  $('#uploader').bind 'fileuploadfail', (e, data) ->
    $('#progress').addClass('red').fadeOut 700, ->
      $('#progress').remove()

      if $('#test_status').val() != 'clicks'
        $('.upload.field .ui.file input').attr 'disabled', false
        $('.upload.field .ui.file .button').removeClass 'disabled'


$(document).ready(ready)
$(document).on('page:load', ready)
