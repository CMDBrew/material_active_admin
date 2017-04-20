$(document).on 'ready page:load turbolinks:load', ->
  # Tab navigation
  $target = $('#active_admin_content .tabs')
  if $target.length
    unless $target.hasClass("disable-jquery-ui-tabs")
      $('#active_admin_content .tabs').tabs()
    $('body').addClass("has_tabs")
