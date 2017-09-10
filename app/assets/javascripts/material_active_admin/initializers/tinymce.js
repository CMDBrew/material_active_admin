ActiveAdmin.TinyMCE = class TinyMCE {
  constructor(options, element) {
    this.options = options;
    this.element = element;

    const defaults = {
      height: 400,
      menubar: false,
      plugins: [
        'advlist autolink lists link image charmap print preview anchor',
        'searchreplace visualblocks code fullscreen',
        'insertdatetime media table contextmenu paste code',
        'table textcolor wordcount hr'
      ],
      toolbar1: 'undo redo | removeformat | table link hr | alignleft aligncenter alignright outdent indent bullist numlist',
      toolbar2: 'formatselect | forecolor backcolor bold italic underline strikethrough blockquote superscript subscript',
      block_formats: 'Header 1=h1; Header 2=h2; Header 3=h3; Header 4=h4; Header 5=h5; Header 6=h6; Paragraph=p',
      browser_spellcheck: true,
      elementpath: false,
      branding: false,
      table_appearance_options: false,
      table_advtab: false,
      table_cell_advtab: false,
      table_row_advtab: false,
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
