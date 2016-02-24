$(document).ready(function() {

    $("#notice_wrapper").slideDown(400).delay(2000).slideUp(400); 

	$("#iconmenu").on("click",function(){
	  $(".menusuperior").toggleClass("normal");
	  $(".menusuperior").toggleClass("desplegado");
	  $(".menulateral").toggleClass("normal");
	  $(".menulateral").toggleClass("desplegado");
	  $(".container").toggleClass("normal");
	  $(".container").toggleClass("desplegado");
	  $(".menu").toggleClass("normal");
	  $(".menu").toggleClass("desplegado");
	  $("li").toggleClass("Mnormal");
	  $("li").toggleClass("Mdesplegado");
	  $(".HomeM").toggleClass("Hnormal");
	  $(".HomeM").toggleClass("Hdesplegado");

	});
});