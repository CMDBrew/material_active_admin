$(document).on 'ready page:load turbolinks:load', ->
  $("#header").find("li.current").addClass("sub-menu-active")
