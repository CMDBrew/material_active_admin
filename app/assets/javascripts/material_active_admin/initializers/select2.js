ActiveAdmin.Select2 = class Select2 {
  constructor(options, element) {
    this.options = options;
    this.element = element;
    this.$element = $(this.element);

    const defaults = {
      'width': '100%',
      'allowClear': true,
      'minimumResultsForSearch': Infinity
    };

    this.options = $.extend(defaults, this.options);
    this.create();
  }

  _dynamic_opts() {
    let placeholder = this.$element.data('select2-placeholder');
    let clear = this.$element.data('select2-clear');

    if(placeholder) $.extend(this.options, { placeholder: placeholder });
    if(clear === 'true') $.extend(this.options, { allowClear: true });

    return this;
  }

  _search_opts() {
    this.options = $.extend(this.options, { minimumResultsForSearch: 0 });
  }

  _other_opts() {
    this.options = $.extend(this.options, {
      createTag: (params) => {
        return {
          id: params.term,
          text: params.term,
          newOption: true
        };
      },
      templateResult: (data) => {
        let $result = $('<span></span>');

        $result.text(data.text);
        if(data.newOption) $result.append(' <em>(other)</em>');

        return $result;
      }
    });
  }

  destroy() {
    this.$element.select2('destroy');
  }

  create() {
    this._dynamic_opts();

    if(this.$element.hasClass('select2-hidden-accessible')) this._destroy();
    if(this.$element.data('select2-search') === 'true') this._search_opts();
    if(this.$element.data('select2-other') === 'true') this._other_opts();

    this.$element.select2(this.options);
    return this;
  }
};

$.widget.bridge('aaSelect2', ActiveAdmin.Select2);
