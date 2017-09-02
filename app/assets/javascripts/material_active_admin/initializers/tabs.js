ActiveAdmin.Tabs = class Tabs {
  constructor(options, element) {
    this.options = options;
    this.element = element;
    this.$element = $(this.element);

    const defaults = {
      activeClass: 'has_tabs',
      excludeClass: 'disable-jquery-ui-tabs'
    };

    this.options = $.extend(defaults, this.options);
    this.create();
  }

  create() {
    $('body').addClass(this.options.activeClass);
    if(this.$element.hasClass('disable-jquery-ui-tabs')) return false;
    this.$element.tabs();
  }
};

$.widget.bridge('aaTabs', ActiveAdmin.Tabs);
