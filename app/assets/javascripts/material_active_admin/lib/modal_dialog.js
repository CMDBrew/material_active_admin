ActiveAdmin.modal_dialog = function(message, inputs, callback, title='Are you sure?'){
  let html = `<div id="dialog_confirm" title="${title}">` +
             `<div class="body"><p>${message}</p></div>` +
             '<form><ul>'
  for (let name in inputs) {
    var elem, opts, wrapper;
    let type = inputs[name];
    if (/^(datepicker|checkbox|text|number)$/.test(type)) {
      wrapper = 'input';
    } else if (type === 'textarea') {
      wrapper = 'textarea';
    } else if ($.isArray(type)) {
      [wrapper, elem, opts, type] = ['select', 'option', type, ''];
    } else {
      throw new Error(`Unsupported input type: {${name}: ${type}}`);
    }

    let klass = type === 'datepicker' ? type : '';
    html += `<li>
      <label>${name.charAt(0).toUpperCase() + name.slice(1)}</label>
      <${wrapper} name="${name}" class="${klass}" type="${type}">` +
        (opts ? ((() => {
          const result = [];

          for (let v of opts) {
            const $elem = $(`<${elem}/>`);
            if ($.isArray(v)) {
              $elem.text(v[0]).val(v[1]);
            } else {
              $elem.text(v);
            }
            result.push($elem.wrap('<div>').parent().html());
          }

          return result;
        })()).join('') : '') +
      `</${wrapper}>` +
    "</li>";
    [wrapper, elem, opts, type, klass] = []; // unset any temporary variables
  }

  html += "</ul></form>";

  const form = $(html).appendTo('body');
  $('body').trigger('modal_dialog:before_open', [form]);

  form.dialog({
    modal: true,
    draggable: false,
    title: title,
    open(event, ui) {
      $('body').trigger('modal_dialog:after_open', [form]);
    },
    dialogClass: 'active_admin_dialog',
    buttons: [
      {
        text: 'Ok',
        "class": 'aa-btn-link brand-primary',
        click() {
          callback($(this).serializeObject())
          $(this).dialog('close')
        }
      },
      {
        text: 'Cancel',
        "class": 'aa-btn-link brand-primary',
        click() {
          $(this).dialog('close').remove()
        }
      }
    ]
  });
};
