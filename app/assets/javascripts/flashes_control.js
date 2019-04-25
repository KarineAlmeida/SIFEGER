var flashesControl = (function() {

  function dismiss () {
    $('.alert-dismissible .close').trigger('click');
  }

  return {
    dismiss: dismiss
  }
})();

$(function () {
  setTimeout(function () {
    flashesControl.dismiss();
  }, 5000);
})
