
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
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require moment
//= require fullcalendar
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

$("html").keyup(function(key){
	var up = key.keyCode;
	if(up == 220){
		$('.container-console').removeClass('hidden');
		activeconsole();
	}
});


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
