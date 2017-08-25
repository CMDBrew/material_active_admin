# @InitSelect2 = ->
#   $("select").each ->
#     if $(@).hasClass "select2-hidden-accessible"
#       $(@).select2("destroy")
#     # if !$(@).data('select2')
#     if $(@).hasClass "select2"
#       $(@).select2
#         placeholder: "Please select one"
#         allowClear: true
#         width: "100%"
#         minimumResultsForSearch: Infinity
#     else if $(@).hasClass "select2-with-search"
#       $(@).select2
#         placeholder: "Please select one"
#         width: "100%"
#         allowClear: true
#     else if $(@).hasClass "select2-with-other-opt"
#       $(@).select2
#         tags: true
#         placeholder: "Please select one"
#         width: "100%"
#         allowClear: true
#         createTag: (params) ->
#           {
#             id: params.term
#             text: params.term
#             newOption: true
#           }
#         templateResult: (data) ->
#           $result = $('<span></span>')
#           $result.text data.text
#           if data.newOption
#             $result.append ' <em>(other)</em>'
#           $result
#     else if $(@).hasClass "select2-no-clear"
#       $(@).select2
#         width: "100%"
#         allowClear: false
#         minimumResultsForSearch: Infinity
#
#
# $(document).on 'ready page:load turbolinks:load', ->
#   InitSelect2()
#
# # $(window).on "resize", ->
# #   InitSelect2()
