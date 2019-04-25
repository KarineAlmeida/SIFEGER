$('#requisite-responsable').on('show.bs.modal', function (event) {
  var $button     = $(event.relatedTarget) // Button that triggered the modal
  var formAction  = $button.data('form-action');
  var selected    = $button.data('current');

  var modal = $(this)
  modal.find('form').attr('action', formAction);
  modal.find('form select').val(selected);
  modal.find('.invalid-feedback').remove();
})
