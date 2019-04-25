
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs

//= require gentelella/vendors/jquery/dist/jquery.min.js
//= require gentelella/vendors/bootstrap/dist/js/bootstrap.min.js
//= require gentelella/vendors/fastclick/lib/fastclick.js
//= require gentelella/vendors/nprogress/nprogress.js
//= require gentelella/vendors/Chart.js/dist/Chart.min.js
//= require gentelella/vendors/gauge.js/dist/gauge.min.js
//= require gentelella/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js
//= require gentelella/vendors/iCheck/icheck.min.js
//= require gentelella/vendors/skycons/skycons.js
//= require gentelella/vendors/Flot/jquery.flot.js
//= require gentelella/vendors/Flot/jquery.flot.pie.js
//= require gentelella/vendors/Flot/jquery.flot.time.js
//= require gentelella/vendors/Flot/jquery.flot.stack.js
//= require gentelella/vendors/Flot/jquery.flot.resize.js
//= require gentelella/vendors/flot.orderbars/js/jquery.flot.orderBars.js
//= require gentelella/vendors/flot-spline/js/jquery.flot.spline.min.js
//= require gentelella/vendors/flot.curvedlines/curvedLines.js
//= require gentelella/vendors/DateJS/build/date.js
//= require gentelella/vendors/jqvmap/dist/jquery.vmap.js
//= require gentelella/vendors/jqvmap/dist/maps/jquery.vmap.world.js
//= require gentelella/vendors/jqvmap/examples/js/jquery.vmap.sampledata.js
//= require gentelella/vendors/moment/min/moment.min.js
//= require gentelella/vendors/bootstrap-daterangepicker/daterangepicker.js
//= require gentelella/vendors/jquery.inputmask/dist/min/jquery.inputmask.bundle.min.js
//= require gentelella/vendors/datatables.net/js/jquery.dataTables.js
//= require gentelella/build/js/custom.min.js


// Components
//= require components/modals/requisite_info.js
//= require components/modals/requisite_responsable_choice.js

// Configs
//= require config/datatables.js
//= require config/tooltips.js
//= require config/tabs.js

//= require flashes_control.js

$(function () {

  var anchor = document.location.href.split('#')[1]

  if(anchor) {
    $('[data-anchor-url="' + anchor +'"]').trigger('click');
  }

  $('[data-anchor-url]').on('click', function () {
    var anchor = $(this).data('anchor-url');
    var url = document.location.href.split('#')[0] + '#' + anchor
    document.location.href = url
  });
})



$(function () {
  $('.timeline-filters select').on('change', function () {
    var value = $(this).val();

    if(value) {
      $.each($('.js-timeline-with-filters li'), function(key, element) {
        var $li = $(element); {
        }if($li.data('requisite-id') == parseInt(value)) {
          $li.removeClass('filter-hidden');
        } else {
          $li.addClass('filter-hidden');
        }
      });
    } else {
      $('.js-timeline-with-filters li').removeClass('filter-hidden');
    }
  })

})

function startStatusesChart () {
  var element = document.getElementById("status-info");
  if (element) {
    var ctx     = element.getContext('2d');
    var data    = $('#status-info').data('data');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: data['labels'],
            datasets: [{
                label: 'Nº de requisitos',
                data: data['values'],
                backgroundColor: data['colors'],
                borderWidth: 0
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    });
  };
}

function startChangesHistory () {
  var element = document.getElementById("changes-history");
  if (element) {
    var ctx     = element.getContext('2d');
    var data    = $('#changes-history').data('data');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: data['labels'],
            datasets: [{
                label: 'Nº de requisitos',
                data: data['values'],
                backgroundColor: data['colors'],
                borderWidth: 0
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    });
  };
}

function startRequisiteByResponsible () {
  var element = document.getElementById("requisite-by-responsible");
  if (element) {
    var ctx     = element.getContext('2d');
    var data    = $('#requisite-by-responsible').data('data');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: data['labels'],
            datasets: [{
                label: 'Nº de requisitos',
                data: data['values'],
                backgroundColor: data['colors'],
                borderWidth: 0
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    });
  };
}




$(function(){
  startStatusesChart();
  startChangesHistory();
  startRequisiteByResponsible();
})
