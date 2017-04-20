@RIPPLE_EFFECT = ((global, $)->
  return {
    events: {
      create_ripple: (event, color_attr="ripple-color")->
        $target   = $(@)
        $div      = $('<div></div>')
        btnOffset = $target.offset()
        xPos      = event.pageX - (btnOffset.left)
        yPos      = event.pageY - (btnOffset.top)
        $div.addClass 'ripple-effect'
        $ripple   = $('.ripple-effect')
        $ripple.css 'height', $target.height()
        $ripple.css 'width', $target.height()
        $div.css(
          top:        yPos - ($ripple.height() / 2)
          left:       xPos - ($ripple.width() / 2)
          background: $target.data(color_attr)
        ).appendTo $target
        window.setTimeout (->
          $div.remove()
        ), 2000
        true
      }
    }
)(window, jQuery)
