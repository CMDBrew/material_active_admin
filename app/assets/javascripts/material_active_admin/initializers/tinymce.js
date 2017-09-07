ActiveAdmin.TinyMCE = class TinyMCE {
  constructor(options, element) {
    this.options = options;
    this.element = element;

    const defaults = {
      height: 500,
      menubar: 'tools table format view insert edit',
      plugins: [
        'advlist autolink lists link image charmap print preview anchor',
        'searchreplace visualblocks code fullscreen',
        'insertdatetime media table contextmenu paste code',
        'table textcolor'
      ],
      toolbar: 'formatselect | forecolor bold italic underline strikethrough blockquote | alignleft aligncenter alignright | outdent indent | bullist numlist | removeformat link',
      block_formats: 'Header 1=h1; Header 2=h2; Header 3=h3; Header 4=h4; Header 5=h5; Header 6=h6; Paragraph=p',
      browser_spellcheck: true,
      content_css: [
        '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i'
      ]
    };

    this.options = $.extend(defaults, this.options);
    this.create();
  }

  destroy() {
    tinymce.remove();
  }

  create() {
    this.options = $.extend(this.options, { target: this.element });
    tinymce.init(this.options);
    return this;
  }
};

$.widget.bridge('aaTinyMCE', ActiveAdmin.TinyMCE);




// @InitTinyMCE = ->
//   tinymce.init
//     mode: 'textareas'
//     editor_selector: 'tinymce'
//     width : "100%"
//     height: 200
//     menubar: false
//     toolbar: 'undo redo | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image'
//     elementpath: false
//     content_css: "/assets/material_active_admin/themes/tinymce-default"
//
// # @InitAdminCommentTinyMCE = ->
// #   tinymce.init
// #     mode: 'textareas'
// #     selector: '#active_admin_comment_body'
// #     height: 200
// #     menubar: false
// #     toolbar: 'undo redo | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image'
// #     elementpath: false
// #     content_css: "/assets/material_active_admin/themes/tinymce-default"
//
//
// $(document).on 'ready page:load turbolinks:load', ->
//   InitTinyMCE()
//   # InitAdminCommentTinyMCE()
//
// $(document).on 'has_many_add:after', ->
//   InitTinyMCE()
//   # InitAdminCommentTinyMCE()
//
// $(window).on "resize", ->
//   console.log "resizing"
//   # InitTinyMCE()
