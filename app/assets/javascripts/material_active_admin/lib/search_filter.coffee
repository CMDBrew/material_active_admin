@SEARCH_FILTER_TOGGLE = ((global, $)->

  return {
    events: {
      show: (event)->
        event.preventDefault()
        $('body').addClass "search-filter-toggled"
        $('#search-filter').addClass "search-filter-toggled"
        false

      hide: (event)->
        $('body').removeClass "search-filter-toggled"
        $('#search-filter').removeClass "search-filter-toggled"
        true
      }
    }
)(window, jQuery)
