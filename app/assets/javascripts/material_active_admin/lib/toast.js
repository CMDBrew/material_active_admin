ActiveAdmin.Toast = class Toast {
  constructor(options, element) {
    this.options = options;
    this.element = element;
    this.$element = $(this.element);
    this.$actions = this.$element.find('.toast-action');

    const defaults = {
      removeClass: 'removing',
      destroyDelay: 4000,
      autoDestroyDelay: 8000,
    };

    this.options = $.extend(defaults, this.options);

    this._bind();
  }

  destroy() {
    this.$element.addClass(this.options.removeClass)
      .delay(this.options.destroyDelay).queue((next) => {
        this.$element.remove();
        next();
      });
    return this;
  }

  _bind() {
    this.$actions.click(() => {
      this.destroy();
      return false;
    });

    setTimeout(() => {
      this.destroy();
      return false;
    }, this.options.autoDestroyDelay);
  }
};

$.widget.bridge('aaToast', ActiveAdmin.Toast);
