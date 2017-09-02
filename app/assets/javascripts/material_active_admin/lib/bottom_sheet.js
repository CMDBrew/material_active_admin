ActiveAdmin.BottomSheet = class BottomSheet {
  constructor(options, element) {
    this.options = options;
    this.element = element;
    this.$element = $(this.element);
    this.$target = $(this.element).parent('.bottom_sheet');

    const defaults = {
      activeClass: 'active'
    };

    this.options = $.extend(defaults, this.options);
    this.isOpen = false;

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
    $('body').click(() => {
      if (this.isOpen) { this.close(); }
    });

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

$.widget.bridge('aaBottomSheet', ActiveAdmin.BottomSheet);
