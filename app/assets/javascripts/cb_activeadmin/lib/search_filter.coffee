@SEARCH_FILTER_TOGGLE = ((global, $)->

  return {
    events: {
      show: (event)->
        event.preventDefault()
        $('body').addClass "search-filter-active"
        $('#search-filter').addClass "search-filter-active"
        false

      hide: (event)->
        $('body').removeClass "search-filter-active"
        $('#search-filter').removeClass "search-filter-active"
        true
      }
    }
)(window, jQuery)
