//= require jquery
//= require active_admin/jquery_ui
//= require jquery_ujs
//= require tinymce
//= require select2-full
//= require_self
//= require active_admin/lib/checkbox-toggler
//= require active_admin/lib/dropdown-menu
//= require active_admin/lib/flash
//= require active_admin/lib/has_many
//= require active_admin/lib/per_page
//= require active_admin/lib/table-checkbox-toggler
//= require active_admin/ext/jquery-ui
//= require active_admin/ext/jquery
//= require active_admin/initializers/batch_actions
//= require active_admin/initializers/datepicker
//= require active_admin/initializers/filters
//= require_tree ./lib
//= require_tree ./initializers
//= require_tree ./vendors

window.ActiveAdmin = {}

const rippleTargets = '.actions .action, .actions .cancel > a, .float_action > a, .nav-btn, .nav-icon, .nav-tabs > li, .header-item li > a, .aa-ripple';

const onDOMReady = function() {
  $('.bottom_sheet_trigger').aaBottomSheet();
  $('#header li.has_nested > a').aaNavMenu();
  $('body').aaSideBarMenu();
  $('body').aaFilterMenu();
  $('.panel.collapse, .inputs.collapse').aaPanel();
  $(':input').aaGuide();
  $('#toast-container').aaToast();
  $("input[type='file']").aaFileInput();
  $('#active_admin_content .tabs').aaTabs();
  $('.select2').aaSelect2();
  $('.tinymce').aaTinyMCE();
  $(rippleTargets).aaRipple();
};

$(document).
  ready(onDOMReady).
  on('page:load turbolinks:load', onDOMReady);

$(document).on('has_many_add:after', '.has_many_container', function(e, fieldset, container) {
  fieldset.find(':input').aaGuide();
  fieldset.find("input[type='file']").aaFileInput();
  fieldset.find('.select2').aaSelect2();
});
