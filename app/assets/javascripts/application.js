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
//= require jquery_ujs
//= require bootstrap-sprockets
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require jquery.turbolinks
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

var categoriesI ;
categoriesI = $('#product_category_id').html();

function miabuela (){
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
      return $('#product_category_id').parent().show();
   } else {
      $('#category_type_product_id').prop("disabled",true);
   }

}
