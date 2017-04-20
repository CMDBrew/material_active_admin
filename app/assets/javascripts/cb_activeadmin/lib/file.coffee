@FILE_UPLOAD = ((global, $)->
  return {
    events: {
      update: (event)->
        $(@).parents(".file-container").find(".file-text").text($(@).val())
        true
      }
    }
)(window, jQuery)
