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
//= require bootstrap-datepicker
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require moment
//= require bootstrap-datetimepicker
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require jsapi
//= require chartkick
//= require jquery-confirm
//= require toastr.min
//= require turbolinks
//= require turbolinks-c
//= require_tree .

//Datatable
function load_datatable(){
  $('#datatable').DataTable({
    "language": {
      "sProcessing":     "Procesando...",
      "sLengthMenu":     "Mostrar  _MENU_  registros",
      "sZeroRecords":    "No se encontraron resultados",
      "sEmptyTable":     "Ningún dato disponible en esta tabla",
      "sInfo":           "_TOTAL_ registros en total.",
      "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
      "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
      "sInfoPostFix":    "",
      "sSearch":         "Buscar:",
      "sUrl":            "",
      "sInfoThousands":  ",",
      "sLoadingRecords": "Cargando...",
      "oPaginate": {
        "sFirst":    "Primero",
        "sLast":     "Último",
        "sNext":     "Siguiente &nbsp;<i class='fa fa-angle-right'></i>",
        "sPrevious": "<i class='fa fa-angle-left'></i>&nbsp; Anterior"
      },
      "oAria": {
        "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
      }
    }
  });
}

toastr.options = {
  "positionClass": "toast-bottom-right",
  "closeButton": true,
  "debug": false,
  "newestOnTop": false,
  "progressBar": true,
  "preventDuplicates": true,
  "onclick": null,
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "3050",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "slideDown",
  "hideMethod": "slideUp"
};

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

/*
$("html").keyup(function(key){
	var up = key.keyCode;
	if(up == 220){
		$('.container-console').removeClass('hidden');
		activeconsole();
	}
});
*/



function activeconsole(){
	var inputReady = true;
	var input = $('.404-input');
	input.focus();
	$('.container').on('click', function(e){
	  input.focus();
	});

	input.on('keyup', function(e){
	  $('.new-output').text(input.val());
	  // console.log(inputReady);
	});

	$('.four-oh-four-form').on('submit', function(e){
	  e.preventDefault();
	  var val = $(this).children($('.404-input')).val().toLowerCase();
	  var href;
		var valsplit = val.split(".");
		switch (valsplit[0]) {
			case "gatos":
					showKittens();
				break;
				case "exit":
						exitform();
					break;
					case "clear":
						clearform();
						break;
				case "help":
					consolehelp();
				break;
				case "reload":
					location.reload();
				break;
				case "url":
					switch (valsplit[1]) {
						case "softkoi":
							softkoiurlmethod(valsplit[2]);
							break;
						case "google":
								googleurl();
							break;
						case "youtube":
							youtubeurl();
						break;
						case "all":
							softkoiurl();
							googleurl()
							youtubeurl();
						break;
						case "help":
							urlhelp();
							break;
						default:
						softkoiurl();
							break;
					}
					break;
				case "translate":
					switch (valsplit[1]) {
						case "español":
								transtaleurlespañol();
							break;
						case "ingles":
							transtaleurlingles();
							break;
						case "help":
							translatehelp();
							break;
						default:
							translateerror();
							break;
					}
					break;
			default:
					resetForm();
				break;
		}
	});
}
