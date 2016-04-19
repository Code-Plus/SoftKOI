
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require select2
//= require select2_locale_es
//= require flipclock.min
//= require bootstrap-datepicker
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require turbolinks
//= require_tree .



$(document).ajaxError(function(event,xhr,options,exc) {

   var errors = JSON.parse(xhr.responseText);
   var kk ="<ul>";

   for(var i = 0; i < errors.length; i++){
      var list = errors[i];
      kk += "<li>"+list+"</li>"
   }

   kk +="</ul>"
   $("#error_explanation").html(kk);
});

// setTimeout(iden_page, 100);



function iden_page(){
  if($('#Reserve_Page').length > 0){
      console.log("si llega hasta el primer if el elemento existe.");
    var dess_page = "noact";
    $('div.m_r_b_reservas').click(function(){
      console.log("Se hizo click en el boton con la clase m_r_b_reservas.");
      dess_page = "siact"
    });
      switch (dess_page) {
        case 'noact':
          console.log("entro en el switch y esta en el caso Noact.");
            if(!$('#new_reserve').length > 0){
              console.log("la modal no existe.");
              setInterval(PageReload, 10000);
            }

          break;
        case 'siact':
        console.log("entro en el switch y esta en el caso Siact.");
            alert('no recargar');
          break;
        default:
      }
  }
}

function PageReload(){
  location.reload();
}

var categoriesI ;
var var_attr ;

categoriesI = $('#product_category_id').html();


function Products_category_function(){
   var categoriesF;
   categoriesF = $('#product_category_id').html();
   $('#product_category_id').parent().show();
   var escaped_type_product, options, type_product;
   type_product = $('#category_type_product_id :selected').text();
   escaped_type_product = type_product.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
   options = $(categoriesF).filter("optgroup[label='" + escaped_type_product + "']").html();
   if (options) {
      $('#product_category_id').html(options);
      $('#category_type_product_id').prop("disabled",true);
      $('#Btn_RProduct').removeClass('disabled');
      $('#Btn_RProduct').removeClass('btn-primary');
      $('#Btn_RProduct').addClass('btn-success');
      return $('#product_category_id').parent().show();
   } else {
      $('#category_type_product_id').prop("disabled",true);
   }

}

// Validar los intervalo de las reservas

function Cargar_En_Reserva(){
  var muestraReloj;
  muestraReloj = function() {
    var fechaHora, horas, minutos, segundos;
    fechaHora = new Date;
    horas = fechaHora.getHours();
    minutos = fechaHora.getMinutes();
    segundos = fechaHora.getSeconds();
    sufijo = ' AM';
    // if (horas > 12) {
    //   horas = horas - 12;
    //   sufijo = ' PM';
    // }
    if (horas < 10) {
      horas = '0' + horas;
    }
    if (minutos < 10) {
      minutos = '0' + minutos;
    }
    if (segundos < 10) {
      segundos = '0' + segundos;
    }
    $('#reserve_start_time').val(horas + ':' + minutos);
  };



  setTimeout(muestraReloj, 1);
  window.onload = function() {
    setInterval(muestraReloj, 60000);
  };

  $('#reserve_reserve_price_id').change(function() {
    var fechaHora, fin, h_split, h_split_f, horas, inter, minutos, rel_fin, second_split, seconds, segundos, send_ini, split_time, split_time_f, sufijo, sum_rel_fin, var_start_time, var_id_interval;
    fechaHora = new Date;
    horas = fechaHora.getHours();
    minutos = fechaHora.getMinutes();
    segundos = fechaHora.getSeconds();

    var id_reserve_price = $('#reserve_reserve_price_id option:selected').val();

    $.ajax({
      url:'/reserves/price_interval',
      data:{id_reserve_price_selected:id_reserve_price},
      type:'get',
      DataType:'json'
    }).done(function(done){

      var price = done['value'];
      $('.field_prices').val(price);

    }).error(function(errors){
      alert(errors);
    });


    // if (horas > 12) {
    //   horas = horas - 12;
    //   sufijo = ' PM';
    // }
    if (horas < 10) {
      horas = '0' + horas;
    }
    if (minutos < 10) {
      minutos = '0' + minutos;
    }
    if (segundos < 10) {
      segundos = '0' + segundos;
    }
    inter = parseInt($('#reserve_reserve_price_id option:selected').text());
    var_start_time = $('#reserve_start_time').val();
    if (var_start_time !== '') {
      split_time = var_start_time.split(':');
      second_split = split_time[1];
      split_time_f = second_split.split(' ');
      rel_fin = parseInt(split_time_f[0]);
      sum_rel_fin = rel_fin + inter;
      if (sum_rel_fin >= '60') {
        h_split = parseInt(split_time[0]);
        h_split_f = h_split + 1;
        fin = sum_rel_fin - 60;
        send_ini = parseInt('00');
        seconds = send_ini + fin;
        if (seconds < 10) {
          seconds = '0' + seconds;
        }
        $('#reserve_end_time').val(h_split_f + ':' + seconds);
      } else {
        h_split = parseInt(split_time[0]);
        // h_split_f = h_split + 1;
        if (h_split < 10) {
          h_split = '0' + h_split;
        }
        seconds = sum_rel_fin;
        $('#reserve_end_time').val(h_split + ':' + seconds);
      }
    }
  });
}


var reloj = new FlipClock($('.clock'), {});

// ajax para traer el precio de la reserva dependiendo el intervalo
