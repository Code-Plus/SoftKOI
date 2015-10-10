$(document).ready(function(){

   $('.ui.checkbox')
     .checkbox();

   $('select.dropdown')
   .dropdown();

  $('.ui.inline.dropdown')
   .dropdown();

   

   //Script de olvidar contraseña
   $(".olvidar").click(function(){
      $('.rescue').modal('show');
   });
   //Script cuando confirma el envio de la contraseña olvidada
  $(".aceptar").click(function(){
      $('.rescue2').modal('show');
   });
  //Scipt de Modal cuando seleccione registrar
        $(".registrar_alquiler").click(function(){
          $('.registro_alquiler').modal('show');
        });
      //Script de Modal cuando seleccione aceptar el registro
        $(".aceptar_alquiler").click(function(){
          $('.registro_alquiler2').modal('show');
        });

});
