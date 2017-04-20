$ ->
  removeFlash = ->
    $('#toast-container').addClass("removing").delay(4000).queue (next) ->
      $(@).remove()
      next()
    return

  setTimeout (->
    removeFlash()
    return
  ), 8000

  $(document).on 'click', '.toast-action', ->
    removeFlash()
    return

$ ->
  $('body').on 'click', "#header li.has_nested > a", NAV_MENU.events.toggle
  $('body').on 'click', "#sidebar-toggle", SIDEBAR_TOGGLE.events.toggle
  $('body').on 'click', "#sidebar-close", SIDEBAR_TOGGLE.events.hide
  $('body').on 'click', "#search-filter-toggle", SEARCH_FILTER_TOGGLE.events.show
  $('body').on 'click', ".search-close", SEARCH_FILTER_TOGGLE.events.hide
  $('body').on 'click', ".with-ripple", RIPPLE_EFFECT.events.create_ripple
  $('body').on 'click', ".panel h3, .inputs legend", ACCORDION_TOGGLE.events.toggle
  $('body').on 'focus', ".mdi-control.with-guide :input", INPUT_GUIDE_EFFECT.events.create_guide
  $('body').on 'blur', ".mdi-control.with-guide :input", INPUT_GUIDE_EFFECT.events.destroy_guide
  $("body").on 'change', "input[type='file']", FILE_UPLOAD.events.update
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
