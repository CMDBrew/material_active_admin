@MDI_INPUT_GUIDE_EFFECT = ((global, $)->
  return {
    events: {
      create_guide: (event, color_attr="guide-color")->
        event.stopPropagation()
        $target     = $(@).parent()
        $div        = $('<div></div>')
        inputOffset = $target.offset()
        $div.addClass 'guide'
        $ripple     = $div
        $div.appendTo $target
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

@INPUT_GUIDE_EFFECT = ((global, $)->
  return {
    events: {
      create_guide: (event, color_attr="guide-color")->
        event.stopPropagation()
        $target     = $(@).parent()
        $div        = $('<div></div>')
        inputOffset = $target.offset()
        $div.addClass 'guide'
        $ripple     = $div
        if $target.data(color_attr)
          $div.css(background: $target.data(color_attr))
        $div.appendTo $target
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
