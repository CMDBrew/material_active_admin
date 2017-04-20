@ACCORDION_TOGGLE = ((global, $)->
  return {
    events: {
      toggle: (event)->
        $target = $(@)
        $actions = $(@).find(".header_action")
        if(event.target == @ ||
           $(@).has(event.target).length != 0 &&
           $actions.has(event.target).length == 0)
          event.preventDefault()
          $target.parent(".panel, .inputs").toggleClass "hidden"
          false
      }
    }
)(window, jQuery)
