@SIDEBAR_TOGGLE = ((global, $)->
  return {
    events: {
      toggle: (event)->
        event.preventDefault()
        $target = $(@)
        $('body').removeClass "search-filter-active"
        $('body').toggleClass "sidebar-toggle"
        false

      hide: (event) ->
        $('body').removeClass "sidebar-toggle"
        false
      }
    }
)(window, jQuery)
