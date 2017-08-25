@MDI_INPUT_GUIDE_EFFECT = ((global, $)->
  return {
    events: {
      create_guide: (event, color_attr="guide-color")->
        return if $(@).is(':input[type=radio], :input[type=checkbox], :input[type=button], :input[type=submit], :input[type=reset]')
        event.stopPropagation()
        $target     = $(@).parent()
        $div        = $('<div></div>')
        inputOffset = $target.offset()
        $div.addClass 'guide'
        $ripple     = $div
        $div.appendTo $target
        $div.css(top: $(@).outerHeight() + $(@).position().top - 1)
        $div.animate(width: $target.width(), 100)
        false

      destroy_guide: (event)->
        event.stopPropagation()
        $target = $(@).parent()
        $target.find(".guide").remove()
        false
    }
  }
)(window, jQuery)
