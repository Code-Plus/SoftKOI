$(document).ready(function() {


	load_datatable();

	$('#registerevent').click(function(){
		$('#myModal').modal();
	});

	// Select autocomplete
	$('#sale_customer_id').select2({
		theme: "bootstrap"
	});

	$('#items_product_id').select2({
		theme: "bootstrap"
	});

	// Datepicker
	$('.datepicker').datepicker({
   	autoclose: true,
		orientation: "bottom auto",
		format: "dd/mm/yyyy"
	});

	// Tooltip y alerta
	$('[data-toggle="tooltip"]').tooltip();
	$("#notice_wrapper").slideDown(400).delay(2000).slideUp("slow");

	// Menu lateral izquierdo
	$("#iconmenu").on("click",function(){
		$(".menusuperior").toggleClass("normal");
		$(".menusuperior").toggleClass("desplegado");
		$(".menulateral").toggleClass("normal");
		$(".menulateral").toggleClass("desplegado");
		$(".container1").toggleClass("normal");
		$(".container1").toggleClass("desplegado");
		$(".menu").toggleClass("normal");
		$(".menu").toggleClass("desplegado");
		$("li").toggleClass("Mnormal");
		$("li").toggleClass("Mdesplegado");
		$(".HomeM").toggleClass("Hnormal");
		$(".HomeM").toggleClass("Hdesplegado");
	});

	$('.McolorHoo').click(function(){
		$(this).trigger("hover");
	});


});
