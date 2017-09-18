ActiveAdmin.FilterMenu = class FilterMenu {
  constructor(options, element) {
    this.options = options;
    this.element = element;
    this.$element = $(this.element);
    this.$target = $('.filter-toggle');

    const defaults = {
      activeClass: 'filter-toggled'
    };

    this.options = $.extend(defaults, this.options);
    this.isOpen = false;

    this._bind();
  }

  open() {
    this.isOpen = true;
    this.$element.addClass(this.options.activeClass);
    return this;
  }

  close() {
    this.isOpen = false;
    this.$element.removeClass(this.options.activeClass);
    return this;
  }

  _bind() {
    this.$target.click(() => {
      if (this.isOpen) {
        this.close();
      } else {
        this.open();
      }
      return false;
    });
  }
};

$.widget.bridge('aaFilterMenu', ActiveAdmin.FilterMenu);
