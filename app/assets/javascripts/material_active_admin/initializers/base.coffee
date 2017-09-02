$ ->
  # $("body").on 'change', "input[type='file']", FILE_UPLOAD.events.update
  $('[data-toggle="tooltip"]').tooltip()

  $.rails.allowAction = (link) ->
    return true unless link.attr('data-confirm')
    $.rails.showConfirmDialog(link) # look bellow for implementations
    false # always stops the action since code runs asynchronously

  $.rails.confirmed = (link) ->
    link.removeAttr('data-confirm')
    link.trigger('click.rails')

  $.rails.showConfirmDialog = (link) ->
    message = link.attr("data-confirm") || ""
    ActiveAdmin.modal_dialog  message, [], -> $.rails.confirmed(link)
