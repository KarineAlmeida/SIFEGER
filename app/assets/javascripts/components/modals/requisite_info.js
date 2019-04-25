$('#requisite-info').on('show.bs.modal', function (event) {
  var $button = $(event.relatedTarget) // Button that triggered the modal
  var json    = $button.data('json');

  var modal = $(this)
  modal.find('.versions_count').text(json['versions_count']);
  modal.find('.state').text(json['state']);
  modal.find('.created_at').text(json['created_at']);
  modal.find('.title').text(json['title']);
  modal.find('.slg').text(json['slg']);
  modal.find('.description').text(json['description']);
  modal.find('.kind').text(json['kind']);
  modal.find('.priority').text(json['priority']);
  modal.find('.responsable').text(json['responsable']);
})

$('#requisite-alert-status-change').on('show.bs.modal', function (event) {
  var $button     = $(event.relatedTarget) // Button that triggered the modal
  var url  = $button.data('url');

  var modal = $(this)
  modal.find('.btn-confirm').attr('href', url);
})
