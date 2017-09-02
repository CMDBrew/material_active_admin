ActiveAdmin.NavMenu = class NavMenu {
  constructor(options, element) {
    this.options = options;
    this.element = element;
    this.$element = $(this.element);
    this.$target = $(this.element).parent('.has_nested');

    const defaults = {
      activeClass: 'sub-menu-active'
    };

    this.options = $.extend(defaults, this.options);

    if (this.$target.hasClass('current')) {
      this.isOpen = true;
      this.$target.addClass(this.options.activeClass);
    } else {
      this.isOpen = false;
    }

    this._bind();
  }

  open() {
    this.isOpen = true;
    this.$target.addClass(this.options.activeClass);
    return this;
  }

  close() {
    this.isOpen = false;
    this.$target.removeClass(this.options.activeClass);
    return this;
  }

  _bind() {
    this.$element.click(() => {
      if (this.isOpen) {
        this.close();
      } else {
        this.open();
      }
      return false;
    });
  }
};

$.widget.bridge('aaNavMenu', ActiveAdmin.NavMenu);
