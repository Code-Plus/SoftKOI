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

   $(".alert").click(function(){
     $('.ui.basic.modal')
       .modal('show');
   });

   $(".win").click(function(){
     $('.primera').modal('show');
   });

   $(".yes").click(function(){
     $('.segunda').modal('show');
   });

});
