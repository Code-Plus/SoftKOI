$(document).ready(function(){

   $('.ui.checkbox')
   .checkbox();

   $('select.dropdown')
   .dropdown();

   $('.ui.inline.dropdown')
   .dropdown();

   $(".aceptar").click(function(){
      $('.rescue2').modal('show');
   });

   $(".olvidar").click(function(){
      $('.rescue').modal('show');
   });


});
