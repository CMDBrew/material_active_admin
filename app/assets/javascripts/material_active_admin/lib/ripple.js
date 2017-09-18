ActiveAdmin.Ripple = class Ripple {
  constructor(options, element) {
    this.options = options;
    this.element = element;
    this.$element = $(this.element);

    const defaults = {
      ripple: "<div></div>",
      rippleClass: 'ripple-effect'
    };

    this.options = $.extend(defaults, this.options);
    this._bind();
  }

  create() {
    $(`.${this.options.rippleClass}`).remove();

    let $ripple = $(this.options.ripple);
    let offset = this.$element.offset();
    let xPos = event.pageX - (offset.left);
    let yPos = event.pageY - (offset.top);

    $ripple.addClass(this.options.rippleClass);
    $ripple.css({
      height: this.$element.height(),
      width: this.$element.height(),
      top:  yPos - ($ripple.height() / 2),
      left: xPos - ($ripple.width() / 2)
    }).appendTo(this.$element);

    window.setTimeout(function(){
      $ripple.remove();
    }, 2000);

    return true;
  }

  _bind() {
    this.$element.click(() => {
      this.create();
      return true;
    });
  }
};

$.widget.bridge('aaRipple', ActiveAdmin.Ripple);
