ActiveAdmin.FileInput = class FileInput {
  constructor(options, element) {
    this.options = options;
    this.element = element;
    this.$element = $(this.element);
    this.$container = this.$element.parents('.file-container');
    this.$fakePath = this.$container.find('.file-text');

    const defaults = {
    };

    this.options = $.extend(defaults, this.options);
    this._bind();
  }

  update() {
    this.$fakePath.text(this.$element.val());
    return this;
  }

  _bind() {
    this.$element.change(() => {
      this.update();
      return true;
    });
  }
};

$.widget.bridge('aaFileInput', ActiveAdmin.FileInput);
