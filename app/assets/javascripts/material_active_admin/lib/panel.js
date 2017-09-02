ActiveAdmin.Panel = class Panel {
  constructor(options, element) {
    this.options = options;
    this.element = element;
    this.$element = $(this.element);
    this.$target = $(this.element).find('h3, legend');
    this.$actions = $(this.element).find('.header_action');

    const defaults = {
      hiddenClass: 'hidden'
    };

    this.options = $.extend(defaults, this.options);
    if (this.$element.hasClass('hidden')) {
      this.isOpen = false;
    } else {
      this.isOpen = true;
    }

    this._bind();
  }

  open() {
    this.isOpen = true;
    this.$element.removeClass(this.options.hiddenClass);
    return this;
  }

  close() {
    this.isOpen = false;
    this.$element.addClass(this.options.hiddenClass);
    return this;
  }

  _bind() {
    this.$target.click(() => {
      if (this.$actions.has(event.target).length) return true;
      if (this.isOpen) {
        this.close();
      } else {
        this.open();
      }
      return false;
    });
  }
};

$.widget.bridge('aaPanel', ActiveAdmin.Panel);
