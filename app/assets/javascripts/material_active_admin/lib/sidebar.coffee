@SIDEBAR_TOGGLE = ((global, $)->
  return {
    events: {
      toggle: (event)->
        event.preventDefault()
        $target = $(@)
        $('body').removeClass "search-filter-toggled"
        $('body').toggleClass "sidebar-toggled"
        false

      hide: (event) ->
        $('body').removeClass "sidebar-toggled"
        false
      }
    }
)(window, jQuery)
