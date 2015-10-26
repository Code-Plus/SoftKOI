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

//SCRIPTS MÓDULO INVENTARIO
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

  //SCRIPTS DEL MODULO CONSOLAS
  //Scipt de Modal cuando seleccione registrar
  $(".registrar_alquiler").click(function(){
    $('.registro_alquiler').modal('show');
  });
      //Script de Modal cuando seleccione aceptar el registro
  $(".aceptar_alquiler").click(function(){
    ('.registro_alquiler2').modal('show');
  });
   //Script del Modal cuando dan en finalizar reserva
  $(".finalizar_alquiler").click(function(){
          $('.finalizar_alquiler2').modal('show');
        });
  //Script del Modal cuando dan si en finalizar reserva
  $(".aceptar_finalizar_alquiler").click(function(){
    $('.finalizar_alquiler3').modal('show');
  });
  //Script del Modal cuando dan en editar reserva
  $(".editar_alquiler").click(function(){
    $('.editar_alquiler2').modal('show');
  });
  //Script del Modal cuando dan en si editar reserva
  $(".aceptar_edicion_alquiler").click(function(){
    $('.editar_alquiler3').modal('show');
  });



  //SCRIPTS DEL MODULO DE USUARIOS
  //Script para cambiar contraseña del perfil
  $(".cambiar_pass").click(function(){
     $('.cambiar_pass2').modal('show');
  });
  //Script para consultar un usuario
  $(".consultar_usuario").click(function(){
    $('.perfil_usuario').modal('show');
  });
  //Script cuando se registra un usuario
  $(".registro_usuario").click(function(){
     $('.registro_usuario2').modal('show');
  });
});
