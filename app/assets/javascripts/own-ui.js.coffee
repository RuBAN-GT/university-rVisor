#= require jquery.address.min.js

Turbolinks.enableProgressBar()

ready = ->
  $(".ui.message .close").on "click", ->
    $(this).closest(".message").transition "fade"

  $(".ui.dropdown, .ui.form .select").find('option[value=""]').val('none')
  $(".ui.dropdown, .ui.form .select").dropdown({
    message: {
      addResult     : 'Добавить <b>{term}</b>',
      count         : '{count} выбрано',
      maxSelections : 'Максимум {maxCount} элементов',
      noResults     : 'Нет результатов.'
    }
  })

  $('.menu.tabs .item').tab({
    history: true
  });

  $('.ui.checkbox').checkbox()

  $(".ui.modal").modal('show')

  $.rails.allowAction = (link) ->
    return true unless link.attr('data-confirm')
    $.rails.showConfirmDialog(link)
    false

  $.rails.confirmed = (link) ->
    link.removeAttr('data-confirm')
    link.trigger('click.rails')

  $.rails.showConfirmDialog = (link) ->
    message = link.attr 'data-confirm'
    html = """
           <div class="ui small modal" id="confirmationDialog">
             <i class="close icon"></i>
             <div class="ui header">
               Внимание!
             </div>
             <div class="content">
               <p>#{message}</p>
             </div>
             <div class="actions">
               <div class="ui cancel close button">Отмена</div>
               <div class="ui positive right labeled icon confirm ok button">
                  Принять <i class="checkmark icon"></i>
               </div>
             </div>
           </div>
           """
    $(html).modal('show')
    $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(link)

$(document).ready ready
$(document).on "page:load", ready