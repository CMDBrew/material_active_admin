ActiveAdmin.Guide = class Guide {
  constructor(options, element) {
    this.options = options;
    this.element = element;
    this.$element = $(this.element);
    this.$target = this.$element.parent();

    const defaults = {
      guide: "<div></div>",
      guideClass: 'guide'
    };

    this.options = $.extend(defaults, this.options);
    this.isFocused = false;
    this._bind();
  }

  create() {
    if(this.$element.is(
      ':input[type=radio], :input[type=checkbox], :input[type=button], :input[type=submit], :input[type=reset]'
    )) return false;

    let $guide = $(this.options.guide);
    let offset = this.$target.offset();

    this.isFocused = true;
    $guide.addClass(this.options.guideClass);
    $guide.appendTo(this.$target);
    $guide.css({top: this.$element.outerHeight() + this.$element.position().top - 1});
    $guide.animate({width: this.$target.width()}, 100);
    return this;
  }

  destroy() {
    this.isFocused = false;
    this.$target.find(`.${this.options.guideClass}`).remove();
    return this;
  }

  _bind() {
    this.$element.focus(() => {
      this.create();
      return false;
    });

    this.$element.blur(() => {
      this.destroy();
      return false;
    });
  }
};

$.widget.bridge('aaGuide', ActiveAdmin.Guide);
