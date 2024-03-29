const BatchAction = function() {
  const activeClass = 'batch-enabled';
  //
  // Use ActiveAdmin.modal_dialog to prompt user if
  // confirmation is required for current Batch Action
  //
  $('.batch_actions_selector li a').click(function(event){
    let message;
    event.stopPropagation(); // prevent Rails UJS click event
    event.preventDefault();
    if ((message = $(this).data('confirm'))) {
      ActiveAdmin.modal_dialog(message, $(this).data('inputs'), inputs => {
        $(this).trigger('confirm:complete', inputs);
      });
    } else {
      $(this).trigger('confirm:complete');
    }
  });

  $('.batch_actions_selector li a').on('confirm:complete', function(event, inputs){
    let val;
    if ((val = JSON.stringify(inputs))) {
      $('#batch_action_inputs').removeAttr('disabled').val(val);
    } else {
      $('#batch_action_inputs').attr('disabled', 'disabled');
    }

    $('#batch_action').val($(this).data('action'));
    $('#collection_selection').submit();
  });

  //
  // Add checkbox selection to resource tables and lists if batch actions are enabled
  //
  if ($(".batch_actions_selector").length && $(":checkbox.toggle_all").length) {

    if ($(".paginated_collection table.index_table").length) {
      $(".paginated_collection table.index_table").tableCheckboxToggler();
    } else {
      $(".paginated_collection").checkboxToggler();
    }

    $(document).on('click', '#selection-toggle', function() {
      $('#collection_selection').find(':checkbox').prop('checked', false);
      $('#collection_selection').find(':checkbox').trigger('change');
    });

    $(document).on('change', '.paginated_collection :checkbox', function() {
      let checkboxLength = $(".paginated_collection :checkbox:checked").length;
      let selectAllChecked = $('#collection_selection_toggle_all').prop('checked');
      if (checkboxLength) {
        if(selectAllChecked) checkboxLength = checkboxLength - 1;
        $('body').addClass(activeClass);
        $('#batch_bar #page_title').find('.count').html(checkboxLength);
      } else {
        $('body').removeClass(activeClass);
      }
    });
  }
};

$(document)
  .ready(BatchAction)
  .on('page:load turbolinks:load', BatchAction);
