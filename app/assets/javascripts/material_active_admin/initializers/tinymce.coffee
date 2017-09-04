# @InitTinyMCE = ->
#   tinymce.init
#     mode: 'textareas'
#     editor_selector: 'tinymce'
#     width : "100%"
#     height: 200
#     menubar: false
#     toolbar: 'undo redo | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image'
#     elementpath: false
#     content_css: "/assets/material_active_admin/themes/tinymce-default"
#
# # @InitAdminCommentTinyMCE = ->
# #   tinymce.init
# #     mode: 'textareas'
# #     selector: '#active_admin_comment_body'
# #     height: 200
# #     menubar: false
# #     toolbar: 'undo redo | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image'
# #     elementpath: false
# #     content_css: "/assets/material_active_admin/themes/tinymce-default"
#
#
# $(document).on 'ready page:load turbolinks:load', ->
#   InitTinyMCE()
#   # InitAdminCommentTinyMCE()
#
# $(document).on 'has_many_add:after', ->
#   InitTinyMCE()
#   # InitAdminCommentTinyMCE()
#
# $(window).on "resize", ->
#   console.log "resizing"
#   # InitTinyMCE()
