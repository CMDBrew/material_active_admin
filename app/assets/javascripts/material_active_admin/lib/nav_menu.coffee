@NAV_MENU = ((global, $)->
  return {
    events: {
      toggle: (event)->
        event.preventDefault()
        $target = $(@)
        $target.parent(".has_nested").toggleClass "sub-menu-active"
        false
      }
    }
)(window, jQuery)
